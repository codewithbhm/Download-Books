
import os
import logging
import time
from concurrent.futures import ThreadPoolExecutor
from urllib.parse import urljoin, urlparse

import requests
from bs4 import BeautifulSoup


def fetch_html(url: str, retries: int = 3, delay: float = 2.0) -> str:
    """
    Fetches the HTML content of the given URL, retrying on failure.

    Args:
        url (str): The web page URL to fetch.
        retries (int): Number of retry attempts on failure.
        delay (float): Delay in seconds between retries.

    Returns:
        str: The fetched HTML content as text, or an empty string on failure.
    """
    headers = {'User-Agent': 'Mozilla/5.0'}
    attempt = 0

    while attempt < retries:
        try:
            response = requests.get(url, headers=headers, timeout=10)
            response.raise_for_status()  # Raise HTTPError for bad responses (4xx, 5xx)
            logging.debug(f"[Response] {url} status: {response.status_code}")
            return response.text
        except requests.RequestException as e:
            attempt += 1
            logging.warning(f"[Retry {attempt}/{retries}] Error fetching {url}: {e}")
            time.sleep(delay)

    logging.error(f"Failed to fetch {url} after {retries} attempts.")
    return ""


def parse_book_links(html: str) -> list[str]:
    """
    Parses HTML of the homepage to extract links to book pages.

    Args:
        html (str): The HTML content of the homepage.

    Returns:
        List[str]: A list of relative URLs to individual book pages.
    """
    soup = BeautifulSoup(html, 'html.parser')
    book_links = []
    containers = soup.find_all("div", class_="bookContainer")
    for container in containers:
        anchor = container.find("a", href=True)
        if anchor:
            link = anchor['href']
            book_links.append(link)
            logging.debug(f"Found book link: {link}")
    return book_links


def parse_pdf_links(html: str) -> list[str]:
    """
    Parses HTML of a book page to extract PDF download links.

    Args:
        html (str): The HTML content of a book page.

    Returns:
        List[str]: A list of relative URLs to PDF files.
    """
    soup = BeautifulSoup(html, 'html.parser')
    pdf_links = []
    for anchor in soup.find_all("a", href=True):
        href = anchor['href']
        if href.lower().endswith('.pdf'):
            pdf_links.append(href)
            logging.debug(f"Found PDF link: {href}")
    return pdf_links


def sanitize_filename(url: str) -> str:
    """
    Sanitizes a URL to create a safe filename.

    Args:
        url (str): The file URL.

    Returns:
        str: A safe filename extracted from the URL.
    """
    parsed = urlparse(url)
    filename = os.path.basename(parsed.path)
    return filename


def download_pdf(pdf_url: str, output_dir: str = 'downloads') -> None:
    """
    Downloads a PDF file from the given URL into the specified directory.

    Args:
        pdf_url (str): The full URL to the PDF file.
        output_dir (str): The directory where PDFs will be saved.
    """
    os.makedirs(output_dir, exist_ok=True)
    filename = sanitize_filename(pdf_url)
    filepath = os.path.join(output_dir, filename)

    # If file already exists, skip download
    if os.path.exists(filepath):
        logging.info(f"✔️ Already exists: {filename}")
        return

    try:
        # Stream the download to handle large files
        response = requests.get(pdf_url, stream=True, timeout=15)
        response.raise_for_status()
        with open(filepath, 'wb') as file:
            for chunk in response.iter_content(chunk_size=8192):
                if chunk:
                    file.write(chunk)
        logging.info(f"✅ Downloaded: {filename}")
    except requests.RequestException as e:
        logging.error(f"❌ Failed to download {pdf_url}: {e}")


def main():
    """
    Main entry point of the program.
    Fetches all book pages from GoalKicker and downloads all PDFs.
    """
    # Configure logging to show level
    logging.basicConfig(level=logging.INFO, format='[%(levelname)s] %(message)s')
    logging.info("🔍 Starting GoalKicker PDF downloader...")

    base_url = 'https://books.goalkicker.com/'
    html = fetch_html(base_url)
    if not html:
        logging.error("⚠️ Could not load the homepage.")
        return

    # Extract links to book pages from homepage
    book_links = parse_book_links(html)
    book_urls = [urljoin(base_url, link) for link in book_links]
    logging.info(f"Found {len(book_urls)} book pages to check.")

    # Extract all PDF links from each book page
    all_pdf_urls = []
    for url in book_urls:
        page_html = fetch_html(url)
        if not page_html:
            continue
        pdf_links = parse_pdf_links(page_html)
        pdf_urls = [urljoin(base_url, pdf) for pdf in pdf_links]
        all_pdf_urls.extend(pdf_urls)

    if not all_pdf_urls:
        logging.info("No PDF files found.")
        return

    logging.info(f"📚 Found {len(all_pdf_urls)} PDF files. Beginning download...")

    # Download PDFs using a thread pool for concurrency
    with ThreadPoolExecutor(max_workers=6) as executor:
        executor.map(download_pdf, all_pdf_urls)

    logging.info("🎉 All downloads completed.")


if __name__ == '__main__':
    main()
