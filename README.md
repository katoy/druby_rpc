
druby をつかって簡易的な rpc の仕組みをつくってみた。
（任意のコマンドを同期 または非同期で実行して、コマンド実行時の標準週力、標準エラーの内容を受け取ることができる)

サーバーの起動
=============

２つコンソールを開く。
１つのコンソールでサーバーを起動する。

    $ ruby server.rb

同期実行
=========

もう一つのコンソールでコマンド実行を呼び出す。

    $ ruby rpc_sync.rb ls
    {:status=>:finish, :cmd=>"ls", :start=>2013-10-03 01:38:07 +0900, :end=>2013-10-03 01:38:08 +0900,
     :ret=>#<Process::Status: pid 17366 exit 0>, :out=>"rpc_async.rb\nrpc_async_log.rb\nrpc_sync.rb\nserver.rb\n",
     :err=>""}

コマンド実行の 開始時間、数量時間、終了ステータス、標準出力、エラー出力の内容が帰ってくる。
この場合は、結果が帰ってくるのは コマンド実行が終わってから。(同期実行)

非同期実行
===========

もう一つのコンソールでコマンド実行を呼び出す。

    $ ruby rpc_async.rb "sleep 10; ls"
    id: {:id=>"4"}

この場合は、すぐにコンソールの制御が戻ってくる。表示されるのは、内部の処理 ID である。
この処理 ID を使って、実行状況や実行結果を問い合わせることができる。
    
    $ ruby rpc_async_log 4
    id=4:  {:status=>"running", :cmd=>"sleep 10; ls", :starTime=>2013-10-03 02:01:25 +0900}

上の表示は、コマンド実行が終了していないことが示されている。

10 秒ほどコマンドが終了した頃に再度 実行すると、今度は 実行結果を得ることができる。

    $ ruby rpc_async_log 4
    id=4:  {:status=>:finish, :cmd=>"sleep 10; ls", :start=>2013-10-03 02:01:01 +0900, :end=>2013-10-03 02:01:11 +0900,
            :ret=>#<Process::Status: pid 17820 exit 0>,
            :out=>"README.md\nREADME.md~\nrpc_async.rb\nrpc_async_log.rb\nrpc_sync.rb\nserver.rb\n", :err=>""}

現状のソースコードでは、同一マシン上でおこなっているが、
druby をつかっているので、サーバーとクライアントを別マシンにして、実行をすることが可能ははずである。
(手元には１台の MAC しかないので ...)
