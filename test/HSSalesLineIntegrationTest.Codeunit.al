namespace HS.Tests;

using HS;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;
using System.TestLibraries.Utilities;
using Microsoft.Sales.Customer;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.VAT.Setup;
using Microsoft.Foundation.UOM;

codeunit 70203 "HS Sales Line Integration Test"
{
    SubType = Test;

    var
        Partner: Record "HS Supplier";
        Item: Record Item;
        SalesLine: Record "Sales Line";
        Assert: Codeunit "Library Assert";

    [Test]
    procedure TestPartnerCopiedFromItem()
    var
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
    begin
        CreatePostingGroups();
        CreateCustomerPostingGroups();
        CreateUnitOfMeasure();


        Customer := CreateValidCustomer('CUST01');


        Partner.Init();
        Partner.Code := 'SUPLINE';
        Partner.Name := 'Line Partner';
        Partner.Insert();


        Item := CreateValidItem('3000', 'SUPLINE');


        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader."No." := 'TST01';
        SalesHeader.Validate("Sell-to Customer No.", 'CUST01');
        SalesHeader.Insert(true);


        SalesLine.Init();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine.Type := SalesLine.Type::Item;
        SalesLine.Insert(true);


        SalesLine.Validate("No.", '3000');

        Assert.AreEqual(
            'SUPLINE',
            SalesLine."HS Supplier Code",
            'Partner Code was not copied from Item.'
        );
    end;

    [Test]
    procedure TestReleaseBlockedPartner()
    var
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
        ReleaseSalesDoc: Codeunit "Release Sales Document";
    begin
        CreatePostingGroups();
        CreateCustomerPostingGroups();
        CreateUnitOfMeasure();

        Customer := CreateValidCustomer('CUST02');


        Partner.Init();
        Partner.Code := 'BLKSAL';
        Partner.Name := 'Blocked Sales Partner';
        Partner.Blocked := true;
        Partner.Insert();


        Item := CreateValidItem('4000', 'BLKSAL');


        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader."No." := 'TSTORDER';
        SalesHeader.Validate("Sell-to Customer No.", 'CUST02');
        SalesHeader.Insert(true);


        SalesLine.Init();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine.Type := SalesLine.Type::Item;
        SalesLine.Insert(true);

        SalesLine.Validate("No.", '4000');
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify(true);
        asserterror ReleaseSalesDoc.PerformManualRelease(SalesHeader);

        Assert.ExpectedError('Supplier Blocked Sales Partner is blocked');
    end;

    local procedure CreateValidCustomer(No: Code[20]): Record Customer
    var
        Cust: Record Customer;
    begin
        Cust.Init();
        Cust."No." := No;
        Cust.Name := 'Test Customer';
        Cust."Customer Posting Group" := 'DOMESTIC';
        Cust."Gen. Bus. Posting Group" := 'DOMESTIC';
        Cust."VAT Bus. Posting Group" := 'VAT20';
        Cust.Insert(true);
        exit(Cust);
    end;

    local procedure CreateValidItem(No: Code[20]; SupplierCode: Code[20]): Record Item
    var
        I: Record Item;
        ItemUOM: Record "Item Unit of Measure";
    begin
        I.Init();
        I."No." := No;
        I.Description := 'Sales Test Item';
        I."Base Unit of Measure" := 'PCS';
        I."Gen. Prod. Posting Group" := 'RETAIL';
        I."Inventory Posting Group" := 'RESALE';
        I."VAT Prod. Posting Group" := 'VAT20';
        I."HS Supplier Code" := SupplierCode;
        I.Insert(true);

        ItemUOM.Init();
        ItemUOM."Item No." := No;
        ItemUOM.Code := 'PCS';
        ItemUOM."Qty. per Unit of Measure" := 1;
        ItemUOM.Insert(true);

        exit(I);
    end;

    local procedure CreatePostingGroups()
    var
        InvPostGroup: Record "Inventory Posting Group";
        GenProdPostGroup: Record "Gen. Product Posting Group";
        VatProdPostGroup: Record "VAT Product Posting Group";
    begin
        if not InvPostGroup.Get('RESALE') then begin
            InvPostGroup.Init();
            InvPostGroup.Code := 'RESALE';
            InvPostGroup.Insert();
        end;

        if not GenProdPostGroup.Get('RETAIL') then begin
            GenProdPostGroup.Init();
            GenProdPostGroup.Code := 'RETAIL';
            GenProdPostGroup.Insert();
        end;

        if not VatProdPostGroup.Get('VAT20') then begin
            VatProdPostGroup.Init();
            VatProdPostGroup.Code := 'VAT20';
            VatProdPostGroup.Insert();
        end;
    end;

    local procedure CreateCustomerPostingGroups()
    var
        CustPost: Record "Customer Posting Group";
        GenBus: Record "Gen. Business Posting Group";
        VatBus: Record "VAT Business Posting Group";
    begin
        if not CustPost.Get('DOMESTIC') then begin
            CustPost.Init();
            CustPost.Code := 'DOMESTIC';
            CustPost.Insert();
        end;

        if not GenBus.Get('DOMESTIC') then begin
            GenBus.Init();
            GenBus.Code := 'DOMESTIC';
            GenBus.Insert();
        end;

        if not VatBus.Get('VAT20') then begin
            VatBus.Init();
            VatBus.Code := 'VAT20';
            VatBus.Insert();
        end;
    end;

    local procedure CreateUnitOfMeasure()
    var
        U: Record "Unit of Measure";
    begin
        if not U.Get('PCS') then begin
            U.Init();
            U.Code := 'PCS';
            U.Insert();
        end;
    end;
}
