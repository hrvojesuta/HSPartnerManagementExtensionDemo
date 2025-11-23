namespace HS;

using Microsoft.Sales.History;

page 70103 "HSSupplier Sales Invoice Lines"
{
    ApplicationArea = All;
    Caption = 'Supplier Posted Sales Invoice Lines Unit Price over 100';
    PageType = List;
    UsageCategory = None;
    SourceTable = "Sales Invoice Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the invoice number.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Item No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the name of the item or general ledger account, or some descriptive text.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the number of units of the item specified on the line.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the price of one unit of the item or resource. You can enter a price manually or have it entered according to the Price/Profit Calculation field on the related card.';
                }
                field("HS Supplier Code"; Rec."HS Supplier Code")
                {
                    ToolTip = 'Specifies the value of the Supplier Code field.', Comment = '%';
                }
            }
        }
    }
}
