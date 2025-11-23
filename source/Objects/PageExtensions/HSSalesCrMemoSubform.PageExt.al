namespace HS;

using Microsoft.Sales.Document;

pageextension 70106 "HS Sales Cr. Memo Subform" extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter(Description)
        {
            field("HS Supplier Code"; Rec."HS Supplier Code")
            {
                ToolTip = 'Specifies the value of the Supplier Code field.', Comment = '%';
                ApplicationArea = All;
                Importance = Promoted;
            }
        }
    }
}
