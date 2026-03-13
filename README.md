# XML Book Catalog

This project demonstrates how to organize and manage book information using **XML**.  
The catalog stores structured metadata about books such as title, author, publisher, and publication year.

The project also demonstrates **DTD validation** and **XPath queries** to ensure correct XML structure and efficient data retrieval.

---

## Project Overview

The XML Book Catalog system is designed to represent book data in a **structured hierarchical format**. XML documents naturally follow a tree-like structure where elements are nested under a root element. :contentReference[oaicite:0]{index=0}  

Using this structure, the catalog organizes book metadata clearly and consistently.

---

## Features

- Structured book data storage using **XML**
- **DTD validation** to enforce document structure
- **XPath queries** to extract specific information
- Simple and readable hierarchical data representation

XPath is commonly used to navigate XML documents and select nodes such as elements or attributes based on specific criteria. :contentReference[oaicite:1]{index=1}

---

## Technologies Used

- XML
- DTD (Document Type Definition)
- XPath

---

## Project Structure

XML-Book-Catalog
│
├── books.xml # XML file containing book catalog data
├── books.dtd # DTD defining the structure of XML
└── README.md

---

## Example XML Structure

```xml
<catalog>
    <book id="1">
        <title>Clean Code</title>
        <author>Robert C. Martin</author>
        <publisher>Prentice Hall</publisher>
        <year>2008</year>
    </book>
</catalog>
Sample XPath Query

Retrieve all book titles:

/catalog/book/title

Retrieve books published after 2010:

/catalog/book[year>2010]
Learning Outcomes

Understanding XML document structure

Working with DTD validation

Using XPath for querying XML data

Representing structured data in a hierarchical format

Author

Sanjay Manikanta Bandaru

GitHub: https://github.com/sanjay-bandaru06

LinkedIn: https://www.linkedin.com/in/sanjay-bandaru-468a79264/
