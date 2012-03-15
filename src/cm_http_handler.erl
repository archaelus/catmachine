%% @copyright Geoff Cant
%% @author Geoff Cant <nem@erlang.geek.nz>
%% @version {@vsn}, {@date} {@time}
%% @doc Default HTTP handler for Catmachine.
%% @end
-module(cm_http_handler).

-behaviour(cowboy_http_handler).
-export([init/3, handle/2, terminate/2]).

init({_Any, http}, Req, []) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    {Path, Req2} = cowboy_http_req:path(Req),
    handle_path(Path, Req2, State).

handle_path([ <<"system_version">> ], Req, State) ->
    {ok, Req2} = cowboy_http_req:reply(200, [{'Content-Type', "text/plain"}],
                                       erlang:system_info(system_version), Req),
    {ok, Req2, State};
handle_path(_, Req, State) ->
    {ok, Req2} = cowboy_http_req:reply(200, [{'Content-Type', "text/plain"}],
                                       <<"Hello world!">>, Req),
    {ok, Req2, State}.

terminate(_Req, _State) ->
    ok.
