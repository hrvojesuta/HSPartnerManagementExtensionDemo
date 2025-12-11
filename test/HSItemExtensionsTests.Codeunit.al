namespace HS.Tests;

using HS;
using System.TestLibraries.Utilities;
using Microsoft.Inventory.Item;
codeunit 70202 "HS Item Extensions Tests"
{
    SubType = Test;

    var
        Partner: Record "HS Supplier";
        Item: Record Item;

    [Test]
    procedure TestAssignPartnerToItem()
    begin
        Partner.Init();
        Partner.Code := 'SUPTEST';
        Partner.Name := 'Test Partner';
        Partner.Insert();

        Item.Init();
        Item."No." := '1000';
        Item.Description := 'Test Item';
        Item.Insert();

        Item."HS Supplier Code" := 'SUPTEST';
        Item.Modify();

        Assert.AreEqual('SUPTEST', Item."HS Supplier Code", 'Partner Code was not assigned to Item.');
    end;

    [Test]
    procedure TestBlockedPartnerOnItem()
    begin
        Partner.Init();
        Partner.Code := 'BLK01';
        Partner.Name := 'Blocked Partner';
        Partner.Blocked := true;
        Partner.Insert();

        Item.Init();
        Item."No." := '2000';
        Item.Description := 'Test Item 2';
        Item.Insert();

        asserterror
        begin
            Item.Validate("HS Supplier Code", 'BLK01');
            Item.Modify(true);
        end;

        Assert.ExpectedError('Supplier Blocked Partner is blocked');
    end;

    var
        Assert: Codeunit "Library Assert";
}
