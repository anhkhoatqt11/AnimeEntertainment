import mongoose from "mongoose";

const paymentHistorySchema = new mongoose.Schema({
    userId: { type: String },
    orderDate: { type: Date },
    paymentMethod: { type: String },
    status: { type: String },
    price: { type: Number },
    packageId: { type: String },
});

type PaymentHistory = mongoose.InferSchemaType<typeof paymentHistorySchema>;

export default mongoose.models.PaymentHistory || mongoose.model<PaymentHistory>("PaymentHistory", paymentHistorySchema);