import { InferSchemaType, model, Schema } from "mongoose";

const genresSchema = new Schema({
  genreName: { type: String },
});

type Genres = InferSchemaType<typeof genresSchema>;

export default model<Genres>("Genres", genresSchema);
