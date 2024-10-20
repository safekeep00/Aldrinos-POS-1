// Call the dataTables jQuery plugin
$(document).ready(() => {
  const transactions = [{ "transaction_no": "167377835903029860", "current_date": "1/15/2024 6:26 PM", "subtotal": "40", "amount_paid": "50", "change": "10.00", "cart": [{ "barcode": "978020137961", "name": "C2 Red", "code": "C2R5HML", "price": 30, "image": "c2-red.png", "total": 30, "qty": 1 }, { "barcode": "100036219082", "name": "Absolute Mineral Water", "code": "AMW500ML", "price": 10, "image": "absolute.png", "total": 10, "qty": 1 }] }, { "transaction_no": "167377838493679293", "current_date": "1/15/2024 6:26 PM", "subtotal": "45", "amount_paid": "50", "change": "5.00", "cart": [{ "barcode": "538276340019", "name": "Coke Mismo", "code": "CMSMO10", "price": 15, "image": "coke.png", "total": 45, "qty": 3 }] }, { "transaction_no": "167377840241750968", "current_date": "1/15/2024 6:26 PM", "subtotal": "75", "amount_paid": "500", "change": "425.00", "cart": [{ "barcode": "889300173211", "name": "Nissin cup nooble Chicken", "code": "NCNCHCKN", "price": 35, "image": "nissin-chicken.png", "total": 35, "qty": 1 }, { "barcode": "978020137961", "name": "C2 Red", "code": "C2R5HML", "price": 30, "image": "c2-red.png", "total": 30, "qty": 1 }, { "barcode": "100036219082", "name": "Absolute Mineral Water", "code": "AMW500ML", "price": 10, "image": "absolute.png", "total": 10, "qty": 1 }] }];

  $('#dataTable').DataTable(
    {
      data: transactions,
      columns: [
        { data: 'current_date' },
        { data: 'transaction_no' },
        { data: 'subtotal' },
        { data: 'amount_paid' },
        { data: 'change' },
        {
          data: 'transaction_no',
          render: (data, type, row) => {
            try {
              return `
                <a href="transactions.html?transaction_no=${data}">
                  View
                </a>
              `;
            } catch (err) {
              console.log(err);
            }
          },
        }
      ],
    }
  );
});
