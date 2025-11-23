namespace HS;

permissionset 70100 HSPartnerManagDemo
{
    Assignable = true;
    Permissions = tabledata "HS Supplier" = RIMD,
        table "HS Supplier" = X,
        report "HS Supplier Item List" = X,
        codeunit "HS Supplier Mgt." = X,
        page "HS Supplier Card" = X,
        page "HS Supplier List" = X,
        page "HSSupplier Sales Invoice Lines" = X;
}