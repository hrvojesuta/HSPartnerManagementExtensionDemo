codeunit 70203 "HS Sales Line Integration Test"
{
    Subtype = Test;

    var
        Partner: Record "HS Supplier";
        Item: Record Item;
        SalesLine: Record "Sales Line";

    [Test]
    procedure TestPartnerCopiedFromItem()
    begin
        // Create partner
        Partner.Init();
        Partner.Code := 'SUPLINE';
        Partner.Name := 'Line Partner';
        Partner.Insert();

        // Create item
        Item.Init();
        Item."No." := '3000';
        Item.Description := 'Sales Test Item';
        Item."HS Supplier Code" := 'SUPLINE';
        Item.Insert();

        // Create Sales Line
        SalesLine.Init();
        SalesLine."Document Type" := SalesLine."Document Type"::Quote;
        SalesLine."Document No." := 'TST01';
        SalesLine.Type := SalesLine.Type::Item;
        SalesLine."No." := '3000';
        SalesLine.Insert(true);

        Assert.AreEqual('SUPLINE', SalesLine."HS Supplier Code", 'Partner Code was not copied from Item.');
    end;

    [Test]
    procedure TestReleaseBlockedPartner()
    var
        SalesHeader: Record "Sales Header";
    begin
        // Create blocked partner
        Partner.Init();
        Partner.Code := 'BLKSAL';
        Partner.Name := 'Blocked Sales Partner';
        Partner.Blocked := true;
        Partner.Insert();

        // Create item using blocked partner
        Item.Init();
        Item."No." := '4000';
        Item.Description := 'Blocked Item';
        Item."HS Supplier Code" := 'BLKSAL';
        Item.Insert();

        // Create document
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader."No." := 'TSTORDER';
        SalesHeader.Insert();

        // Create Sales Line with blocked partner
        SalesLine.Init();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine.Type := SalesLine.Type::Item;
        SalesLine."No." := '4000';
        SalesLine.Insert(true);

        // Attempt to release
        asserterror begin
            Codeunit.Run(Codeunit::"Release Sales Document", SalesHeader);
        end;

        Assert.ExpectedError('Supplier is Blocked.');
    end;
}