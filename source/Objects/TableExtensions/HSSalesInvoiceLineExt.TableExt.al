namespace HS;

using Microsoft.Sales.History;

tableextension 70105 "HS Sales Invoice Line Ext." extends "Sales Invoice Line"
{
    fields
    {
        field(70100; "HS Supplier Code"; Code[20])
        {
            Caption = 'Supplier Code';
            DataClassification = CustomerContent;
            TableRelation = "HS Supplier";
        }
    }
}
