namespace HS;

using Microsoft.Sales.Document;

pageextension 70105 "HS Sales Invoice Subform" extends "Sales Invoice Subform"
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
