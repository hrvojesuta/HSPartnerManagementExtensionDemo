codeunit 70202 "HS Item Extensions Tests"
{
      Subtype = Test;

    var
        Partner: Record "HS Supplier";
        Item: Record Item;

    [Test]
    procedure TestAssignPartnerToItem()
    begin
        // Create partner
        Partner.Init();
        Partner.Code := 'SUPTEST';
        Partner.Name := 'Test Partner';
        Partner.Insert();

        // Create item
        Item.Init();
        Item."No." := '1000';
        Item.Description := 'Test Item';
        Item.Insert();

        // Assign partner
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

        asserterror begin
            Item."HS Supplier Code" := 'BLK01';
            Item.Modify(true);
        end;

        Assert.ExpectedError('Supplier is Blocked.');
    end;
}
