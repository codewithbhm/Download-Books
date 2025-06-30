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

Citations:
[1] GoalKicker.com: Free Programming Books https://books.goalkicker.com
[2] Free Python Programming Book - GoalKicker.com https://books.goalkicker.com/PythonBook/
[3] Web Scraping with Python: A Step-by-Step Guide https://dev.to/emmanuelj/web-scraping-with-python-a-step-by-step-guide-1e4e
[4] python-web-scraping-tutorial-step-by-step https://pypi.org/project/python-web-scraping-tutorial-step-by-step/
[5] Documentation — The Hitchhiker's Guide to Python https://docs.python-guide.org/writing/documentation/
[6] Documenting Python Code: A Complete Guide https://realpython.com/documenting-python-code/
[7] Alteryx, Inc. ; AYX ; 1689923 ; 10-k ; 2024-02-06 https://www.sec.gov/Archives/edgar/data/1689923/000168992324000006/ayx-20231231.htm
[8] Molecular Templates, Inc. ; MTEM ; 1183765 ; 10-k ; 2023-03-30 https://www.sec.gov/Archives/edgar/data/1183765/000156459023004898/mtem-10k_20221231.htm
[9] Molecular Templates, Inc. ; MTEM ; 1183765 ; 10-k ; 2022-03-29 https://www.sec.gov/Archives/edgar/data/1183765/000156459022012055/mtem-10k_20211231.htm
[10] IGTA Merger Sub Ltd ; NO_TICKER ; 1997698 ; s-4 ; 2024-02-07 https://www.sec.gov/Archives/edgar/data/1997698/000121390024010904/fs42024_igtamerger.htm
[11] LEGALZOOM.COM, INC. ; LZ ; 1286139 ; 10-k ; 2023-03-01 https://www.sec.gov/Archives/edgar/data/1286139/000128613923000036/lz-20221231.htm
[12] Molecular Templates, Inc. ; MTEM ; 1183765 ; 10-k ; 2024-03-29 https://www.sec.gov/Archives/edgar/data/1183765/000155837024004332/mtem-20231231x10k.htm
[13] Development of Electronic Books Using Website 2 APK Builder Pro Based on Science, Technology, Engineering, and Mathematics (STEM) to Improve Learning Outcomes https://jppipa.unram.ac.id/index.php/jppipa/article/view/5182
[14] Information System Renting and Renting Books By Website Based Host To Host https://pels.umsida.ac.id/index.php/PELS/article/view/838
[15] Rancangan Sistem Informasi Perpustakaan Berbasis Website Menggunakan Barcode Di Sekolah MA Raden Rahmat http://jurnal.unidha.ac.id/index.php/jteksis/article/view/740
[16] Design and Website Design for Vivree Photography https://journal.uc.ac.id/index.php/VCD/article/view/2834
[17] Emotion-Based Literature Books Recommender Systems https://annals-csis.org/Volume_35/drp/8647.html
[18] Picturing Bravery: A Rapid Review of Needle Procedures Depicted in Children’s Picture Books https://www.mdpi.com/2227-9067/10/7/1097
[19] Making a PyPI-friendly README¶ https://packaging.python.org/en/latest/guides/making-a-pypi-friendly-readme/
[20] All the books from goalkicker.com! - GitHub https://github.com/Dkra/goalkicker-books
[21] Making a PyPI-friendly README - Python Packaging User Guide https://packaging.python.org/guides/making-a-pypi-friendly-readme/
[22] The Art of Web Scraping with Python https://python.plainenglish.io/the-art-of-web-scraping-with-python-a86c9fef8982?gi=1d059ee1c1aa
[23] GoalKicker.com - Free Programming Books - LinkedIn https://www.linkedin.com/company/goalkicker
[24] Nu Holdings Ltd. ; NO_TICKER ; 1691493 ; 20-f ; 2025-04-16 https://www.sec.gov/Archives/edgar/data/1691493/000129281425001517/nuform20f_2024.htm
[25] Six Flags Entertainment Corporation/NEW ; FUN ; 1999001 ; def14a ; 2025-05-09 https://www.sec.gov/Archives/edgar/data/1999001/000119312525116917/d840238ddef14a.htm
[26] TNL Mediagene ; NO_TICKER ; 2013186 ; 20-f ; 2025-04-30 https://www.sec.gov/Archives/edgar/data/2013186/000121390025037450/ea0238878-20f_tnlmedia.htm
[27] Karooooo Ltd. ; NO_TICKER ; 1828102 ; 20-f ; 2025-06-09 https://www.sec.gov/Archives/edgar/data/1828102/000121390025052372/ea0244872-20f_karooooo.htm
[28] RPM Interactive, Inc. ; NO_TICKER ; 2018293 ; s-1 ; 2025-06-16 https://www.sec.gov/Archives/edgar/data/2018293/000121390025054837/ea0243614-s1_rpminter.htm
[29] Catalyst Crew Technologies Corp. ; NO_TICKER ; 1477960 ; 10-k ; 2025-04-23 https://www.sec.gov/Archives/edgar/data/1477960/000147793225002922/cbbb_10k.htm
[30] Article template for Elemental Microscopy https://doi.curvenote.com/10.69761/TAMJ0615
[31] Investigating the Landscape of Ontologies for Catalysis Research Data Management https://www.tib-op.org/ojs/index.php/CoRDI/article/view/232
[32] Automata and Computability Education via Jove https://dl.acm.org/doi/10.1145/3408877.3439547
[33] All hail reproducibility in microbiome research https://microbiomejournal.biomedcentral.com/articles/10.1186/2049-2618-2-8
[34] Natural Language Processing for Autonomous Identification of Impactful Changes to Specification Documents https://ieeexplore.ieee.org/document/9256611/
[35] Free and Customizable Code Documentation with LLMs: A Fine-Tuning
  Approach http://arxiv.org/pdf/2412.00726.pdf
[36] Make a README https://www.makeareadme.com
[37] 5 Professional Tips for Crafting a Winning README! https://hackernoon.com/5-professional-tips-for-crafting-a-winning-readme
[38] Creating Great README Files for Your Python Projects - Real Python https://realpython.com/readme-python-project/
[39] How To Write a README? : r/learnprogramming https://www.reddit.com/r/learnprogramming/comments/vxfku6/how_to_write_a_readme/
[40] README.md - rochacbruno/python-project-template - GitHub https://github.com/rochacbruno/python-project-template/blob/main/README.md
[41] Professional README Guide | The Full-Stack Blog https://coding-boot-camp.github.io/full-stack/github/professional-readme-guide/
[42] Python Documentation Best Practices: A Complete Guide for ... https://www.docuwriter.ai/posts/python-documentation-best-practices-guide-modern-teams
[43] python-package-template/README.md at main - GitHub https://github.com/allenai/python-package-template/blob/main/README.md
[44] Beautiful Thing NY Limited Partnership ; NO_TICKER ; 1958447 ; form_d ; 2022-12-15 https://www.sec.gov/Archives/edgar/data/1958447/0001958447-22-000001-index.htm
[45] Chicken Soup for the Soul Entertainment, Inc. ; CSSE ; 1679063 ; 10-k ; 2024-04-19 https://www.sec.gov/Archives/edgar/data/1679063/000155837024005371/csse-20231231x10k.htm
[46] Chicken Soup for the Soul Entertainment, Inc. ; CSSE ; 1679063 ; 10-k ; 2022-03-31 https://www.sec.gov/Archives/edgar/data/1679063/000155837022004926/csse-20211231x10k.htm
[47] Chicken Soup for the Soul Entertainment, Inc. ; CSSE ; 1679063 ; 10-k ; 2023-03-31 https://www.sec.gov/Archives/edgar/data/1679063/000155837023005316/csse-20221231x10k.htm
[48] Beautiful Thing NY Limited Partnership ; NO_TICKER ; 1958447 ; form_d/a ; 2023-04-17 https://www.sec.gov/Archives/edgar/data/1958447/0001958447-23-000001-index.htm
[49] Beautiful Noise Cast Album LLC ; NO_TICKER ; 1949721 ; form_d ; 2022-10-11 https://www.sec.gov/Archives/edgar/data/1949721/0001949721-22-000001-index.htm
[50] Emotional Insights into Online Lectures: A Text-Driven Analysis Using Naive Bayes During the Pandemic Times https://ieeexplore.ieee.org/document/10365640/
[51] VULNERABILITY ANALYSIS PIPELINE USING COMPILER BASED SOURCE TO SOURCE TRANSLATIONS AND DEEP LEARNING https://proceedings.elseconference.eu/index.php?paper=793e60186fc687b6ceb93645aba099ce
[52] A review of programming languages for web scraping from software repository sites http://www.enggjournals.com/ijet/docs/IJET17-09-03-505.pdf
[53] Teamwork makes the dream work: LLMs-Based Agents for GitHub README.MD
  Summarization https://arxiv.org/html/2503.10876v1
[54] Implementation of web scraping on github task monitoring system http://journal.uad.ac.id/index.php/TELKOMNIKA/article/download/11613/6204
[55] Trafilatura: A Web Scraping Library and Command-Line Tool for Text Discovery and Extraction https://aclanthology.org/2021.acl-demo.15.pdf
[56] Crawl and download Readme.md files from GitHub using python https://stackoverflow.com/questions/72449966/crawl-and-download-readme-md-files-from-github-using-python
[57] Web scraping and parsing with Beautiful Soup 4 Introduction https://pythonprogramming.net/introduction-scraping-parsing-beautiful-soup-tutorial/
[58] README Template | Handbook - Technical Direction https://docs.devland.is/misc/gitbook-template
[59] How to Scrape GitHub Data Repository With Python - ScraperAPI https://www.scraperapi.com/web-scraping/github/
[60] Beautiful Soup: Web Scraping with Python (Beginner friendly) https://dev.to/serpapi/beautiful-soup-web-scraping-with-python-beginner-friendly-45gd
[61] requests https://pypi.org/project/requests/0.10.0/
[62] Sankha1998/web-scraping-examples - GitHub https://github.com/Sankha1998/web-scraping-examples
[63] A guide to web scraping in Python using Beautiful Soup https://opensource.com/article/21/9/web-scraping-python-beautiful-soup
[64] <!-- Improved compatibility of back https://raw.githubusercontent.com/othneildrew/Best-README-Template/master/README.md
[65] README.md - KeithGalli/web-scraping - GitHub https://github.com/KeithGalli/web-scraping/blob/master/README.md
[66] Molecular Templates, Inc. ; MTEM ; 1183765 ; 10-q ; 2022-08-12 https://www.sec.gov/Archives/edgar/data/1183765/000156459022029202/mtem-10q_20220630.htm
[67] Molecular Templates, Inc. ; MTEM ; 1183765 ; 10-q ; 2022-05-13 https://www.sec.gov/Archives/edgar/data/1183765/000156459022019985/mtem-10q_20220331.htm
[68] Molecular Templates, Inc. ; MTEM ; 1183765 ; 10-q ; 2024-08-14 https://www.sec.gov/Archives/edgar/data/1183765/000155837024012257/mtem-20240630x10q.htm
[69] Molecular Templates, Inc. ; MTEM ; 1183765 ; 10-q ; 2022-11-10 https://www.sec.gov/Archives/edgar/data/1183765/000156459022037419/mtem-10q_20220930.htm
[70] An Empirical Research on Confucius Old Books Website: the Differences of Default for Bidders in Online Auction http://ieeexplore.ieee.org/document/4421850/
[71] Discussion on How University Library to Collect Local Literatures by Using the Second-hand Books Website https://www.semanticscholar.org/paper/c06b2fa75354171311d9147c75346538451305cb
[72] RANCANG BANGUN SISTEM INFORMASI INVENTARIS BARANG PADA SMP NEGERI 01 RUNJUNG AGUNG BERBASIS WEBSITE https://jurnal.stkippgritulungagung.ac.id/index.php/jipi/article/view/3201
[73] Analisis Transaksi Jual Beli online Melalui Website Marketplace Shopee Menurut Konsep Bisnis di Masa Pandemic Covid 19 https://www.semanticscholar.org/paper/b33b7c291003e63273540fb58732ddd8122fd26b
[74] Web Scraping With Python [A Beginner-friendly Guide] https://www.simplilearn.com/tutorials/python-tutorial/web-scraping-with-python
[75] Upstart Holdings, Inc. ; UPST ; 1647639 ; 10-k ; 2025-02-14 https://www.sec.gov/Archives/edgar/data/1647639/000164763925000018/upst-20241231.htm
[76] Mobile Tickets Dashboard https://www.semanticscholar.org/paper/9299660f4a8bbacc4a4d306833aa81686244abb6
[77] JuICe: A Large Scale Distantly Supervised Dataset for Open Domain Context-based Code Generation https://www.aclweb.org/anthology/D19-1546.pdf
[78] CodeExp: Explanatory Code Document Generation https://aclanthology.org/2022.findings-emnlp.174.pdf
[79] tableone: An open source Python package for producing summary statistics for research papers https://academic.oup.com/jamiaopen/article-pdf/1/1/26/32298238/ooy012.pdf
[80] Beautiful Noise First Tour LLC ; NO_TICKER ; 2021437 ; form_d ; 2024-04-29 https://www.sec.gov/Archives/edgar/data/2021437/0002021437-24-000001-index.htm
[81] CAMPBELL SOUP CO ; CPB ; 16732 ; 10-k ; 2024-09-19 https://www.sec.gov/Archives/edgar/data/16732/000001673224000130/cpb-20240728.htm
[82] Beautiful Noise LLC ; NO_TICKER ; 1897092 ; form_d ; 2021-12-03 https://www.sec.gov/Archives/edgar/data/1897092/0001897092-21-000001-index.htm
[83] Cricut, Inc. ; CRCT ; 1828962 ; 10-k ; 2022-03-09 https://www.sec.gov/Archives/edgar/data/1828962/000182896222000018/crct-20211231.htm
[84] Fundus: A Simple-to-Use News Scraper Optimized for High Quality
  Extractions https://arxiv.org/html/2403.15279v1
[85] Read between the lines -- Functionality Extraction From READMEs https://arxiv.org/html/2403.10205v1
[86] Web Scraping Using R https://nottingham-repository.worktribe.com/preview/2654310/Webscraping%20Using%20R%20AAM.pdf
[87] Dr Web: a modern, query-based web data retrieval engine https://arxiv.org/html/2504.05311v1
