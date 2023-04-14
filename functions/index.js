const functions = require("firebase-functions");
require("dotenv").config();
const stripe = require("stripe")(process.env.STRIPE_SECRET);

exports.stripePayment = functions.https.onCall(async (request, response) => {
  try {
    const number = request.number;
    const month = request.month;
    const year = request.year;
    const cvv = request.cvv;
    const amount = request.amount;
    const description = request.description;
    try {
      var token = await stripe.tokens.create({
        card: {
          number: number,
          exp_month: month,
          exp_year: year,
          cvc: cvv,
        },
      });

      try {
        await stripe.charges
          .create({
            amount: amount * 100,
            currency: "usd",
            source: token.id,
            description: description,
          })
          .then((data) => {
            response = { msg: "Payment Successfully Done", data };
          });
        return response;
      } catch (error) {
        response = { error };
        return response;
      }
    } catch (e) {
      return "payment Error!";
    }
  } catch (err) {
    response = err;
    return "Server Error";
  }
});
