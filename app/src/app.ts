import Koa from "koa";
import Router from "koa-router";

const app = new Koa();

const router = new Router();

router.get("/ping", ctx => {
  ctx.status = 200;
  ctx.body = "pong";
});

app.use(router.routes());

const server = app.listen(3000, () => console.log("Listening on PORT: 3000"));

export default server;
