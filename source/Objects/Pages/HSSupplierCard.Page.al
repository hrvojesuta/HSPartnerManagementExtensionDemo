namespace HS;
using HS;
using Microsoft.Inventory.Item;
using Microsoft.Sales.History;

page 70101 "HS Supplier Card"
{
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Supplier Card';
    PageType = Card;
    SourceTable = "HS Supplier";


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field.', Comment = '%';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
                }
                field("No. of Items"; Rec."No. of Items")
                {
                    ToolTip = 'Specifies the value of the No. of Items field.', Comment = '%';
                }
                group(Communication)
                {
                    Caption = 'Communication';
                    field("Contact No."; Rec."Contact No.")
                    {
                        ToolTip = 'Specifies the value of the Contact No. field.', Comment = '%';
                    }
                    field("Contact Name"; Rec."Contact Name")
                    {
                        ToolTip = 'Specifies the value of the Contact Name field.', Comment = '%';
                    }
                    field(Address; Rec.Address)
                    {
                        ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                    }
                    field("Home No."; Rec."Home No.")
                    {
                        ToolTip = 'Specifies the value of the Home No. field.', Comment = '%';
                    }
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ToolTip = 'Specifies the value of the E-Mail field.', Comment = '%';
                    }
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action(HSShowItems)
                {
                    ApplicationArea = All;
                    Caption = 'Items';
                    Image = AddContacts;
                    ToolTip = 'Executes the Items action.';

                    trigger OnAction()
                    var
                        Item: Record Item;
                    begin
                        Item.Reset();
                        Item.SetRange("HS Supplier Code", Rec."Code");
                        Page.Run(Page::"Item List", Item);
                    end;

                }
                action(HSDuplicateSupplier)
                {
                    ApplicationArea = All;
                    Caption = 'Duplicate Supplier';
                    Image = Copy;
                    ToolTip = 'Executes the Duplicate Supplier action.';

                    trigger OnAction()
                    var
                        SupplierMgt: Codeunit "HS Supplier Mgt.";
                    begin
                        SupplierMgt.CreateNewSupplier(Rec);
                        Message('Supplier duplicated successfully.');
                    end;
                }
                action(HSQtyOnSalesLine)
                {
                    ApplicationArea = All;
                    Caption = 'Qty. on Sales Line';
                    Image = Copy;
                    ToolTip = 'Executes the Quantity on Sales Line action.';

                    trigger OnAction()
                    var
                        SupplierMgt: Codeunit "HS Supplier Mgt.";
                    begin
                        SupplierMgt.ShowSalesLineQty(Rec);
                    end;
                }
                action(HSPostedSalesInvoiceLines)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoice Lines';
                    Image = Document;
                    ToolTip = 'Executes the Posted Sales Invoice Lines action.';

                    trigger OnAction()
                    var
                        SalesInvoiceLine: Record "Sales Invoice Line";
                    begin
                        SalesInvoiceLine.SetRange("HS Supplier Code", Rec.Code);
                        SalesInvoiceLine.SetFilter("Unit Price", '>%1', 100);
                        PAGE.Run(PAGE::"HSSupplier Sales Invoice Lines", SalesInvoiceLine);
                    end;
                }
            }
        }
    }
}
