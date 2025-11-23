namespace HS;

using Microsoft.Sales.Document;

pageextension 70104 "HS Sales Order Subform" extends "Sales Order Subform"
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
