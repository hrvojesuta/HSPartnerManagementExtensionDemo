# HSPartnerManagementExtensionDemo
This repository contains a simple, portfolio-friendly AL extension for Microsoft Dynamics 365 Business Central. It demonstrates essential AL development skills used in real-world BC projects.


📦 HS Partner Management Extension (Demo Project)

A lightweight AL extension for Microsoft Dynamics 365 Business Central, created as a clean demo project to showcase fundamental AL development skills.
This project is intentionally simple and easy to read — ideal for recruiters, other developers, or anyone reviewing code quality.

✨ Features
🧩 Partner Master Data

Custom Partner table

Partner Card & Partner List pages

Address parsing (street & house number separation)

Automatic email generation from Partner Name + Company

FlowField: count of assigned items

🔗 Item Integration

Adds Partner Code to the Item table

Partner shown on Item Card

Validation for blocked partners

📄 Sales Document Integration

Automatically copies Partner Code from Item → Sales Line

Partner Code added to Sales Order, Invoice, Credit Memo, and Posted Invoice pages

Prevents releasing a Sales Order when the partner is blocked

📊 Reporting

“Partner Item List” report (RDLC)

Shows all items grouped by partner

Triggered from Page Action

🛠 How to Install & Run

Clone the repository

Open it in Visual Studio Code

Configure launch.json with your sandbox details

Press Ctrl + F5 to publish the extension

In Business Central:

Tell Me → Partner List

📁 Project Structure
test/
source/
  Objects/
    Codeunits/
    Enums/
    PageExtensions/
    Pages/
    Reports/
    TableExtensions/
    Tables/
  rdlc/
  Translations/
  app.json


🧠 Skills Demonstrated

AL object design

Page & table extension techniques

Codeunit business logic

Event subscribers

Validation patterns

RDLC reporting

FlowFields and CalcFormula

Page Actions & UI customization

Clean project structure & naming conventions


Future improvements
Tests for this project

🎯 Purpose of This Project

This is a basic, clean demo project intended to show understanding of fundamental AL concepts.

📜 License

Free to use for personal learning and portfolio purposes.
