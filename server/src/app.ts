import "dotenv/config";
import express, {NextFunction, Request, Response} from "express";
// import morgan from "morgan"
import createHttpError, {isHttpError} from "http-errors";
import cors from "cors"
//import route ---------------------------------------------------------
import userRoutes from "./routes/user"
import comicRoutes from "./routes/comics"
//----------------------------------------------------------------------
const app = express();

// app.use(morgan("dev"))

app.use(express.json())

app.use(express.urlencoded({
    extended: true
}));

// disable cors policy
const allowedOrigins = ['*'];
app.use(cors({
  origin: function(origin, callback){
    if (!origin) {
      return callback(null, true);
    }

    if (allowedOrigins.includes(origin)) {
      const msg = 'The CORS policy for this site does not allow access from the specified Origin.';
      return callback(new Error(msg), false);
    }
    return callback(null, true);
  }

}));


// use route -------------------------------------------------
app.use("/api/users", userRoutes);
app.use("/api/comics", comicRoutes);

//------------------------------------------------------------

app.use((req, res, next) => {
    next(createHttpError(404,"Endpoint not found"));
});

app.use((error: unknown, req: Request, res: Response, next:NextFunction)=> {
    console.error(error);
    let errorMessage = "An unknown error occured";
    let statusCode = 500;
    if ( isHttpError(error) )
    {
        statusCode = error.status;
        errorMessage = error.message;
    } 
    res.status(statusCode).json({error:errorMessage})
});


export default app;