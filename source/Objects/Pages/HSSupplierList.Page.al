namespace HS;

page 70102 "HS Supplier List"
{
    ApplicationArea = All;
    Caption = 'Supplier List';
    PageType = List;
    SourceTable = "HS Supplier";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "HS Supplier Card";
    AdditionalSearchTerms = 'Supplier, Dealer, Merchant, Trader, Stockist, Provider, Distributor';
    SourceTableView = sorting(Name) order(ascending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
                }
            }

        }
    }
}
