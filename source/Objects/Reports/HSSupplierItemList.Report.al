namespace HS;

using Microsoft.Foundation.Company;
using System.Environment;
using Microsoft.Inventory.Item;

report 70100 "HS Supplier Item List"
{
    ApplicationArea = All;
    Caption = 'Supplier Item List';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './rdlc/HSSupplierItemList.rdlc';
    DataAccessIntent = ReadOnly;
    dataset
    {
        dataitem(HSSupplier; "HS Supplier")
        {
            DataItemTableView = sorting("Code");
            RequestFilterFields = Code, Name;
            column(ItemSupplierLbl; ItemSupplierLbl) { }
            column(CompanyInfoV; CompanyInfo) { }
            column(TodayDateV; TodayDate) { }
            column(CurrUserV; CurrUser) { }
            column("Code"; "Code")
            {
            }
            column(Name; Name)
            {
            }
            column(Address; Address)
            {
            }
            column(HomeNo; "Home No.")
            {
            }
            column(Type; "Type")
            {
            }
            dataitem(Item; Item)
            {
                DataItemTableView = sorting("No.");
                DataItemLink = "HS Supplier Code" = field(Code);
                column(ItemNo; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Description_2; "Description 2")
                { }
                column(Inventory; Inventory)
                { }
                column(Unit_Cost; "Unit Cost") { }
                column(Unit_Price; "Unit Price") { }
            }
            trigger OnAfterGetRecord()
            begin
                if TodayDate = 0D then begin
                    TodayDate := Today();
                    CurrUser := UserId();
                    CompanyInfo := GetCompanyInfo();
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    var
        ItemSupplierLbl: Label 'Item Supplier List';
        CompanyInfo: Text[100];
        TodayDate: Date;
        CurrUser: Text;

    local procedure GetCompanyInfo(): Text[100]
    var
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.Get();
        CompanyInfo := CompanyInformation.Name;
        exit(CompanyInfo);
    end;
}
