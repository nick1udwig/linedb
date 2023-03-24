/-  *screed, ldb=linedb
/+  dbug, default-agent, linedb, *mip
::
%-  agent:dbug
^-  agent:gall
=>  |%
    +$  versioned-state
      $%  state-0
      ==
    +$  state-0
      $:  %0
          published=(map path html=@t)
          history=_branch:linedb
          comments=(mip path line:ldb comment) :: TODO should probably be listified so that we can have a thread of comments
      ==
    +$  card  card:agent:gall
    --
=|  state-0
=*  state  -
=<  |_  =bowl:gall
    +*  this  .
        hc    ~(. +> bowl)
        def   ~(. (default-agent this %|) bowl)
    ++  on-init
      ^-  (quip card _this)
      `this(history (add-commit:history our.bowl ~)) :: TODO this starts at v 1 which is a little weird instead of 0
    ++  on-save  !>(state)
    ++  on-load
      |=  =vase 
      ^-  (quip card _this)
      =+  !<(old=versioned-state vase)
      ?-  -.old
        %0  `this(state old)
      ==
    ::
    ++  on-poke
      |=  [=mark =vase]
      =^  cards  state
        ?+  mark  (on-poke:def mark vase)
          %handle-http-request  (http-req:hc !<([@tas inbound-request:eyre] vase))
          %screed-action        (handle-action:hc !<(act=action vase))
        ==
      [cards this]
    ::
    ++  on-agent  on-agent:def
    ++  on-watch
      |=  =path
      ^-  (quip card _this)
      ?>  ?=([%http-response *] path)
      `this
    ::
    ++  on-peek  handle-scry:hc
    ::
    ++  on-arvo
      |=  [=wire =sign-arvo]
      ^-  (quip card _this)
      ?+  wire  (on-arvo:def wire sign-arvo)
        [%bind ~]  ?>(?=([%eyre %bound %.y *] sign-arvo) `this)
      ==
    ++  on-leave  on-leave:def
    ++  on-fail   on-fail:def
    --
::
|_  bowl=bowl:gall
++  http-req
  |=  [rid=@tas req=inbound-request:eyre]
  ^-  (quip card _state)
  `state
++  handle-action
  |=  act=action
  ^-  (quip card _state)
  ?>  =(src our):bowl :: TODO for group blogs
  ?-    -.act
      %publish
    :_  state(published (~(put by published) [path html]:act))
    [%pass /bind %arvo %e %connect `path.act dap.bowl]~
  ::
      %commit-file
    :: TODO any comments have to be adjusted. See "Operational Transform"
    =.  history.state
      =/  =snapshot:ldb     latest-snap:history
      =/  new=snapshot:ldb  (~(put by snapshot) [path md]:act)
      (add-commit:history.state src.bowl new)
    
    `state
  ::
      %comment
    =:  author.comment.act     src.bowl
        timestamp.comment.act  now.bowl
      ==
    `state(comments (~(put bi comments) [path line comment]:act))
  ==
++  handle-scry
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  `~
  ::
      [%x %head ~]   ``noun+!>(head:history)
      [%x %files ~]
    =+  snapshot:(got:snap-on:ldb snaps.history head:history)
    ``noun+!>((turn ~(tap by -) head))
  ::
      [%x %latest ^]
    ``noun+!>((get-version:history t.t.path head:history))
  ::
      [%x %v @ ^]
    =*  version    (slav %ud i.t.t.path)
    =*  file-name  t.t.t.path
    ``noun+!>((get-version:history file-name version))
  ==
--