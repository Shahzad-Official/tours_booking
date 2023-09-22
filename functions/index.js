const functions = require("firebase-functions");
require("dotenv").config();
const stripe = require("stripe")(process.env.SECRET);

exports.payNow = functions.https.onRequest(async (req, res) => {
    const { number, month, year, cvc, amount, name } = req.body;
  
    await stripe.tokens
      .create({
        card: {
          number: number,
          exp_month: month,
          exp_year: year,
          cvc: cvc,
          name: name,
        },
      })
      .then(async (value) => {
        await stripe.charges
          .create({
            amount: amount * 100,
            currency: "usd",
            source: value.id,
            description: "Booking has been done",
          })
          .then((newVal) => {
            res.send({ result: newVal });
          })
          .catch((err) => {
            res.send({ error: err.message });
          });
      })
      .catch((err) => {
        res.send({ error: err.message });
      });
  });