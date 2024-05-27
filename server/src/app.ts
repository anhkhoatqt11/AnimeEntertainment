import "dotenv/config";
import express, {
  NextFunction,
  Request,
  RequestHandler,
  Response,
} from "express";
// import morgan from "morgan"
import createHttpError, { isHttpError } from "http-errors";
import cors from "cors";
import bodyParser from "body-parser";
import cookieParser from "cookie-parser";
import session from "express-session";
//import route ---------------------------------------------------------
import userRoutes from "./routes/user";
import comicRoutes from "./routes/comics";
import authRoutes from "./routes/auth";
import animeRoutes from "./routes/animes";
import donateRoutes from "./routes/donatePackage";
import challengeRoutes from "./routes/challenge";
import dailyRequestRoutes from "./routes/quest";
import paymentRoutes from "./routes/payment";
import userReportRoutes from "./routes/userReport";
import { isAuthenticated } from "./middlewares";
//----------------------------------------------------------------------
const app = express();
declare module "express-session" {
  interface SessionData {
    user: string;
  }
}

// app.use(morgan("dev"))

app.use(express.json());

app.use(
  express.urlencoded({
    extended: true,
  })
);

// disable cors policy
const allowedOrigins = ["*"];
app.use(
  cors({
    origin: function (origin, callback) {
      if (!origin) {
        return callback(null, true);
      }

      if (allowedOrigins.includes(origin)) {
        const msg =
          "The CORS policy for this site does not allow access from the specified Origin.";
        return callback(new Error(msg), false);
      }
      return callback(null, true);
    },
  })
);

app.use(bodyParser.urlencoded({ extended: true }));
app.use(
  session({
    secret: "subscribe",
    resave: true,
    saveUninitialized: false,
    cookie: {
      maxAge: 60 * 60 * 24,
    },
  })
);

app.use(cookieParser());
// auth

// use route -------------------------------------------------
app.use("/api/auth", authRoutes);
// use middleware if routes need to be protected
// app.use("/api/users", isAuthenticated,userRoutes);
app.use("/api/users", userRoutes);
app.use("/api/comics", comicRoutes);
app.use("/api/animes", animeRoutes);
app.use("/api/donates", donateRoutes);
app.use("/api/challenges", challengeRoutes);
app.use("/api/quest", dailyRequestRoutes);
app.use("/api/reports", userReportRoutes);
app.use("/api/payment", paymentRoutes);

//------------------------------------------------------------

app.use((req, res, next) => {
  next(createHttpError(404, "Endpoint not found"));
});

app.use((error: unknown, req: Request, res: Response, next: NextFunction) => {
  console.error(error);
  let errorMessage = "An unknown error occured";
  let statusCode = 500;
  if (isHttpError(error)) {
    statusCode = error.status;
    errorMessage = error.message;
  }
  res.status(statusCode).json({ error: errorMessage });
});

export default app;
