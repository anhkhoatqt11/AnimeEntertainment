import { cleanEnv } from "envalid";
import { port, str } from "envalid/dist/validators"


export default cleanEnv(process.env, {
    MONGO_CONNECTION_STRING: str(),
    PORT: port(),
    SEND_SMS_API: str(),
    DATABASE_URL: str(),
})