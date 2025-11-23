namespace HS;

using Microsoft.Sales.History;

pageextension 70107 "HSPosted Sales Invoice Subform" extends "Posted Sales Invoice Subform"
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
