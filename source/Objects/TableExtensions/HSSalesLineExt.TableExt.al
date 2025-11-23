namespace HS;

using Microsoft.Sales.Document;

tableextension 70104 "HS Sales Line Ext." extends "Sales Line"
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
