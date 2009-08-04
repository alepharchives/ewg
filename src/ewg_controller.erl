%%
%% Sample default "/" controller, implement this to your needs
%%
-module(ewg_controller,[Env]).

-export([handle_request/2,before_filter/0]).

handle_request("index",[]) ->
    {render,"ewg/index.html",[{data,"Hello There From EWG!"}]};

handle_request("run",[]) ->
    ewg_generator:generate_words(""),
    {render,"ewg/index.html",[{data,"Wordlist generation just started!"}]};

handle_request("options",[]) ->
    ewg_dumper:dump_options(),
    {render,"ewg/index.html",[{data,"See stdout!"}]};

handle_request("statistics",[]) ->
    Stats = ewg_validator:statistics(),
    {render,"ewg/index.html",[{data,Stats}]}.

before_filter() ->
    %% Shows how to potentially filter on certain actions in this
    %% controller
    FilterOnly = ["show"],
    case lists:member(beepbeep_args:get_action(Env),FilterOnly) of
	true ->
	    error_logger:info_report("Doing the filter for SHOW~n"),
	    ok;
	false ->
	    ok
    end.

    
