namespace HS;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;

codeunit 70100 "HS Supplier Mgt."
{
    procedure CheckAndFormatAddress(var Address: Text[100]): Integer
    var
        i: Integer;
        Char: Text;
        Digits: Text[20];
    begin
        Digits := '';
        i := StrLen(Address);

        while (i > 0) do begin
            Char := CopyStr(Address, i, 1);
            if Char in ['0' .. '9'] then
                Digits := Char + Digits
            else
                break;
            i -= 1;
        end;

        if Digits <> '' then begin
            Address := DelStr(Address, i + 1);
            Address := CopyStr(Address.Trim(), 1, StrLen(Address));
            exit(this.EvaluateToInt(Digits));
        end else
            exit(0);
    end;

    local procedure EvaluateToInt(Value: Text): Integer
    var
        Result: Integer;
    begin
        if not Evaluate(Result, Value) then
            Result := 0;
        exit(Result);
    end;

    procedure GenerateSupplierEMail(Name: Text[100]; CompanyName: Text[100]): Text[80]
    var
        ConfirmTxt: Label 'Would you like to set E-Mail based on Supplier Name and Company Name?';
        EmailLbl: Label '%1@%2.com', Locked = true;
    begin
        if (Name = '') or (CompanyName = '') then
            exit('');
        if not Confirm(ConfirmTxt, false) then
            exit('');


        Name := CopyStr(Name.Trim(), 1, MaxStrLen(Name));
        while StrPos(Name, '  ') > 0 do
            Name := CopyStr(Name.Replace('  ', ' '), 1, MaxStrLen(Name));

        Name := CopyStr(LowerCase(Name).Replace(' ', '.'), 1, MaxStrLen(Name));




        CompanyName := CopyStr(CompanyName.Trim(), 1, MaxStrLen(CompanyName));
        while StrPos(CompanyName, '  ') > 0 do
            CompanyName := CopyStr(CompanyName.Replace('  ', ' '), 1, MaxStrLen(CompanyName));

        CompanyName := CopyStr(LowerCase(CompanyName).Replace(' ', '.'), 1, MaxStrLen(CompanyName));

        exit(StrSubstNo(EmailLbl, Name, CompanyName));
    end;


    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'HS Supplier Code', false, false)]
    local procedure OnAfterValidateItemSupplierCode(var Rec: Record Item; xRec: Record Item)
    var
        Supplier: Record "HS Supplier";
        SupplierBlockedLbl: Label 'Supplier %1 is blocked', comment = '%1 - Supplier ID';
    begin
        if Rec."HS Supplier Code" <> '' then
            if Supplier.Get(Rec."HS Supplier Code") then
                if Supplier.Blocked then
                    Error(SupplierBlockedLbl, Supplier.Name);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterCopyFromItem', '', false, false)]
    local procedure OnAfterCopyFromItemSupplierCode(var SalesLine: Record "Sales Line"; Item: Record Item; CurrentFieldNo: Integer; xSalesLine: Record "Sales Line")
    var
        Supplier: Record "HS Supplier";
    begin
        if Supplier.Get(item."HS Supplier Code") then
            if Supplier.Code <> '' then
                SalesLine."HS Supplier Code" := Supplier."Code";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeManualReleaseSalesDoc', '', false, false)]
    local procedure OnBeforeManualReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    var
        SalesLine: Record "Sales Line";
        Supplier: Record "HS Supplier";
        SupplierBlockedLbl: Label 'Supplier %1 is blocked. Line no. %2, No. %3', comment = '%1 - Supplier ID, %2 - Line No., %3 - Item No.';
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        if SalesLine.FindSet() then
            repeat
                if SalesLine."HS Supplier Code" <> '' then
                    if Supplier.Get(SalesLine."HS Supplier Code") then
                        if Supplier.Blocked then
                            Error(SupplierBlockedLbl, Supplier.Name, SalesLine."Line No.", SalesLine."No.");
            until SalesLine.Next() = 0;

    end;

    procedure CreateNewSupplier(Supplier: Record "HS Supplier")
    var
        NewSupplier: Record "HS Supplier";
    begin

        NewSupplier.Init();
        NewSupplier.TransferFields(Supplier, true);

        NewSupplier.Code := IncStr(Supplier.Code);
        Clear(NewSupplier."E-Mail");
        Clear(NewSupplier."Contact No.");

        NewSupplier.Insert(true);
    end;

    procedure ShowSalesLineQty(Supplier: Record "HS Supplier")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset();
        SalesLine.SetRange("HS Supplier Code", Supplier.Code);
        SalesLine.CalcSums(Quantity);

        Message('Sales Line total quantity is: %1',
            Format(SalesLine."Quantity", 0, '<Precision,2:2><Standard Format,0>'));
    end;

}
