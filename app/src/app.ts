import Koa from "koa";
import loaderRoutes from "./loaderRoutes";

const app = new Koa();

loaderRoutes(app);

const server = app.listen(3000, () => console.log("Listening on PORT: 3000"));

export default server;
