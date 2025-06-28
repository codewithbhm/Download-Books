import os
import time
import logging
import urllib.request
from html.parser import HTMLParser
from urllib.parse import urljoin, urlparse
from concurrent.futures import ThreadPoolExecutor

# ----------------------------
# GoalKicker HTML Parser Class
# ----------------------------
class GoalKickerParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.book_links = []
        self.pdf_links = []
        self._in_book_container = False

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if tag == 'div' and 'class' in attrs and 'bookContainer' in attrs['class']:
            self._in_book_container = True
        elif self._in_book_container and tag == 'a' and 'href' in attrs:
            self.book_links.append(attrs['href'])
        elif tag == 'a' and 'href' in attrs and attrs['href'].endswith('.pdf'):
            self.pdf_links.append(attrs['href'])

    def handle_endtag(self, tag):
        if tag == 'div' and self._in_book_container:
            self._in_book_container = False

# ----------------------------
# Fetch HTML with retry logic
# ----------------------------
def fetch_html(url, retries=3, delay=2):
    headers = {'User-Agent': 'Mozilla/5.0'}
    for attempt in range(retries):
        try:
            req = urllib.request.Request(url, headers=headers)
            with urllib.request.urlopen(req) as response:
                return response.read().decode('utf-8')
        except Exception as e:
            logging.warning(f"[Retry {attempt+1}] Error fetching {url}: {e}")
            time.sleep(delay)
    return ''

# ----------------------------
# Clean filename from URL
# ----------------------------
def sanitize_filename(url):
    return os.path.basename(urlparse(url).path)

# ----------------------------
# Download PDF File
# ----------------------------
def download_pdf(pdf_url, output_dir='downloads'):
    os.makedirs(output_dir, exist_ok=True)
    filename = sanitize_filename(pdf_url)
    filepath = os.path.join(output_dir, filename)

    if os.path.exists(filepath):
        logging.info(f"✔️ Already exists: {filename}")
        return

    try:
        with urllib.request.urlopen(pdf_url) as response:
            with open(filepath, 'wb') as file:
                file.write(response.read())
        logging.info(f"✅ Downloaded: {filename}")
    except Exception as e:
        logging.error(f"❌ Failed to download {pdf_url}: {e}")

# ----------------------------
# Main Function
# ----------------------------
def main():
    logging.basicConfig(level=logging.INFO, format='[%(levelname)s] %(message)s')

    base_url = 'https://books.goalkicker.com/'
    homepage_html = fetch_html(base_url)
    if not homepage_html:
        logging.error("⚠️ Failed to load GoalKicker homepage.")
        return

    homepage_parser = GoalKickerParser()
    homepage_parser.feed(homepage_html)

    book_urls = [urljoin(base_url, link) for link in homepage_parser.book_links]
    all_pdf_urls = []

    for book_url in book_urls:
        book_html = fetch_html(book_url)
        if not book_html:
            continue

        book_parser = GoalKickerParser()
        book_parser.feed(book_html)
        pdf_links = [urljoin(base_url, link) for link in book_parser.pdf_links]
        all_pdf_urls.extend(pdf_links)

    if not all_pdf_urls:
        logging.info("No PDF links found.")
        return

    logging.info(f"📚 Found {len(all_pdf_urls)} PDF(s). Starting download...")

    with ThreadPoolExecutor(max_workers=6) as executor:
        executor.map(download_pdf, all_pdf_urls)

    logging.info("🎉 All downloads completed.")

# ----------------------------
# Entry Point
# ----------------------------
if __name__
