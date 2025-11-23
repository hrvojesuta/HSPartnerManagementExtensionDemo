namespace HS;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Reports;

pageextension 70103 "HS Item Card" extends "Item Card"
{
    layout
    {
        addafter("Base Unit of Measure")
        {
            field("HS Supplier Code"; Rec."HS Supplier Code")
            {
                ToolTip = 'Specifies the value of the Supplier Code field.', Comment = '%';
                ApplicationArea = All;
                Importance = Promoted;
            }
        }
    }
    actions
    {
        addafter(Identifiers)
        {
            action("HS Inventory Top 10")
            {
                ApplicationArea = All;
                Caption = 'Inventory Top 10';
                Image = InventoryJournal;
                RunObject = Report "Inventory - Top 10 List";
                ToolTip = 'Executes the Inventory Top 10 action.';
            }
        }
        addafter("Va&riants")
        {
            action("HS Supplier Item List")
            {
                ApplicationArea = All;
                Caption = 'Supplier Item List';
                Image = ItemLines;
                RunObject = Report "HS Supplier Item List";
                ToolTip = 'Executes the Supplier Item List action.';
            }
        }
    }
}
