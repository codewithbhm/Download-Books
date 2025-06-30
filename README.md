# GoalKicker PDF Downloader

A Python web scraper that automatically downloads all programming books from the GoalKicker website.

## Description

This tool crawls the GoalKicker website (https://books.goalkicker.com/) to find and download all available PDF programming books[1]. GoalKicker offers free programming books compiled from Stack Overflow Documentation[1][2]. The scraper extracts book links from the homepage, visits each book's individual page, and downloads the PDFs to a local directory.

## Features

- **Automated Discovery**: Automatically finds all book pages from the GoalKicker homepage
- **PDF Detection**: Extracts PDF download links from individual book pages  
- **Concurrent Downloads**: Uses ThreadPoolExecutor with 6 workers for efficient parallel downloading
- **Smart Retry Logic**: Implements retry mechanism with exponential backoff for failed requests
- **Duplicate Prevention**: Skips downloads if files already exist locally
- **Progress Logging**: Provides detailed logging of the download process
- **Robust Error Handling**: Gracefully handles network errors and invalid responses

## Installation

### Prerequisites

- Python 3.6 or higher
- pip package manager

### Required Dependencies

```bash
pip install requests beautifulsoup4
```

## Usage

### Basic Usage

1. Clone or download the script
2. Install dependencies:
   ```bash
   pip install requests beautifulsoup4
   ```
3. Run the script:
   ```bash
   python goalkicker_downloader.py
   ```

The script will:
- Create a `downloads` directory (if it doesn't exist)
- Scan the GoalKicker homepage for book links
- Visit each book page to find PDF download links
- Download all PDFs to the `downloads` folder

### Configuration

You can modify these parameters in the script:

- **Output Directory**: Change `output_dir='downloads'` in the `download_pdf()` function
- **Concurrent Workers**: Modify `max_workers=6` in the ThreadPoolExecutor
- **Retry Attempts**: Adjust `retries=3` in the `fetch_html()` function
- **Delay Between Retries**: Change `delay=2.0` in the `fetch_html()` function

## Technical Details

### Libraries Used

- **requests**: HTTP library for making web requests and downloading files[3][4]
- **BeautifulSoup**: HTML parsing library for extracting data from web pages[3][4]
- **concurrent.futures**: For parallel PDF downloads
- **urllib.parse**: For URL manipulation and joining
- **logging**: For progress tracking and error reporting
- **os**: For file system operations

### How It Works

1. **Homepage Parsing**: Fetches the GoalKicker homepage and finds all `div` elements with class "bookContainer"
2. **Link Extraction**: Extracts href attributes from anchor tags within book containers
3. **Book Page Scanning**: Visits each book page and searches for links ending with '.pdf'
4. **Concurrent Downloading**: Downloads multiple PDFs simultaneously using ThreadPoolExecutor
5. **File Management**: Creates sanitized filenames and checks for existing files

### Error Handling

The script includes comprehensive error handling for:
- Network connectivity issues
- Invalid HTML responses
- Missing PDF links
- File system errors
- HTTP timeouts

## Sample Output

```
[INFO] 🔍 Starting GoalKicker PDF downloader...
[INFO] Found 45 book pages to check.
[INFO] 📚 Found 45 PDF files. Beginning download...
[INFO] ✅ Downloaded: PythonNotesForProfessionals.pdf
[INFO] ✅ Downloaded: JavaNotesForProfessionals.pdf
[INFO] ✔️ Already exists: CSharpNotesForProfessionals.pdf
[INFO] 🎉 All downloads completed.
```

## Legal and Ethical Considerations

- This tool is designed for educational purposes
- GoalKicker provides free programming books, and this scraper respects their robots.txt[1]
- The script includes reasonable delays and limits concurrent requests to avoid overwhelming the server
- All downloaded content is freely available from the original source

## Contributing

Feel free to submit issues or pull requests to improve the functionality or add new features such as:
- Filter downloads by programming language
- Resume interrupted downloads  
- Support for other free programming book sites
- GUI interface for easier use

## License

This project is provided as-is for educational purposes. Please respect the terms of service of the websites being scraped.

**Note**: Always verify that you have permission to scrape websites and respect their robots.txt files and terms of service[5][6].

