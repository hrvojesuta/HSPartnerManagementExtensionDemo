namespace HS;

using Microsoft.Inventory.Item;

tableextension 70103 "HS Item" extends Item
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
