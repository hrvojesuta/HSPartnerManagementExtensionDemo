namespace HS;

using Microsoft.CRM.Contact;
using Microsoft.Inventory.Item;

table 70101 "HS Supplier"
{
    Caption = 'Supplier';
    DataClassification = CustomerContent;
    LookupPageId = "HS Supplier List";
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            trigger OnValidate()
            begin
                "E-Mail" := this.SupplierMgt.GenerateSupplierEMail(Name, "Company Name");
            end;
        }
        field(3; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
            trigger OnValidate()
            begin
                "E-Mail" := this.SupplierMgt.GenerateSupplierEMail(Name, "Company Name");
            end;
        }
        field(4; Address; Text[100])
        {
            Caption = 'Address';
            trigger OnValidate()

            begin
                "Home No." := this.SupplierMgt.CheckAndFormatAddress(Address);
            end;
        }
        field(5; "Home No."; Integer)
        {
            Caption = 'Home No.';
        }
        field(6; Type; Enum "HS Supplier Type")
        {
            Caption = 'Type';
        }
        field(7; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(8; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(9; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact;
            trigger OnValidate()
            var
                Contact: Record Contact;
            begin
                Contact.Reset();
                Contact.SetRange("No.", "Contact No.");
                if Contact.FindFirst() then
                    "Contact Name" := Contact.Name
                else
                    "Contact Name" := '';
            end;
        }
        field(10; "Contact Name"; Text[100])
        {
            Caption = 'Contact Name';
        }
        field(11; "No. of Items"; Integer)
        {
            Caption = 'No. of Items';
            FieldClass = FlowField;
            CalcFormula = count(Item where("HS Supplier Code" = filter(<> '')));
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(Key1; Name)
        {
            Clustered = false;
        }
    }
    fieldgroups
    {
        fieldgroup(Dropdown; "Code", "Name", Type)
        {
            Caption = 'Dropdown';
        }
    }
    var
        SupplierMgt: Codeunit "HS Supplier Mgt.";
}
