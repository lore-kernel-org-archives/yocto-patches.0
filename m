Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E331099B52
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 23:39:53 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2433.1774049986925446979
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Mar 2026 16:39:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FO0jDaYX;
 spf=pass (domain: gmail.com, ip: 209.85.167.182, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-464bba3a9easo1416850b6e.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Mar 2026 16:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774049986; x=1774654786; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfESbAP5RdJYQFEAvTtxRroUq/bNgQGtJStvZ9cgV78=;
        b=FO0jDaYXcxwS7n21JhSA05mIiWp/9tdfuNJh/RGb/IFif6VtQ6s4bZjWVDFe/z5ASb
         M13mMk95fci7lqqMZCDU61r6xONFl5jSy2/SGrV8qHfcpPGvQcru/OquSmy9mnwGhuCq
         Cj/MZJPUA2EZFVrKD9K/OqYoOd37yXFqcK81GpqrKqV0UpwOaeHG+ZJlmxu4+KJqEYHl
         I+x3OST7XuYZosno4m+NgkOdMR+Or10A89EzoaIrBaPqrhNLnR5C4Z5P2T1tiWJ9tQyd
         +TMdQQWfm8rCoslbOl4XAl6tq9dduhDJbl6YWsaUHChznwENew0bE1APkyhIJsuE7v7c
         hrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774049986; x=1774654786;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfESbAP5RdJYQFEAvTtxRroUq/bNgQGtJStvZ9cgV78=;
        b=Y+Ku50er3FQil769uRejl3CbdWHzClbm4AvX3vyKF6Ny5uQtsle1b78gKKRrucUO94
         Qbv+FBrIC2TSXSbkDgCHBHzm8j5uXZvEuRxy+Xia8yYNOpM58/s8aI1J0A1txm/60hcf
         XuPMJqnQod2Wj6kjGAqpx9JeWejFDEVkw0q6wvYvk6g0Mdvnne2gZOfpao8G0Rhwlco8
         kMCDgtPnvhLeUfUwLHt0JD5DNXS6kgebJ8CbQKk1UP6U9Z7yZ/2ovLMv6CBWVvMFBAEw
         L2sNBrMOglGh8WKowftCZSpgR2yolWWyJwEAlp812cRWr8m4t/NrMfGJzMRmPa1xCGb0
         xx5w==
X-Forwarded-Encrypted: i=1; AJvYcCW/e/mpLGTeTptXYhBsb46KsEm6HtC7XLUyY9uGJbv7VIOfd9L4oYLz8fe+S9RySc4Y1MXSrHFvfkhMOVRC@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwZHvyv0/VmJ+sCmTQT+K11SUI77l1PTRt0NRDqv3h+f6mpgZ/e
	joTSQj6wf+a9twfXGNc0MQPNHzCHx1dxEH7/ZWlEBRripvLe4Z+g9sAR
X-Gm-Gg: ATEYQzz+9VN5lvbZ6J3a0EUK3MWQHkFBJqE30CxLhd+HyfNBMo0bE8viChNewgXhCJj
	UGsWf/+zRPW8Z4IRMCQJGONr9Dt7M+d8ev9Q5iJuFIUdkSlIk2wyXk9lZ4IhuNJ+e4WRM2JNiTw
	I1PcYbojHZI6sXenryW0kNT4/o25N1e+sRXom5NAG27+bmMGsukZzLSBOg30RCOdGslJQlZNNQt
	Y7GHOD5ra5GbpoZPSnvYSz+kbDikXKgN2231guHJORuiBbrkT3D6Ctz0ys2HLuIab/nedH4xbTU
	k8hUM3Ys0R5rdc1nf4fYGkGw2oUoljgEg5lEZLMi2NDjnnP5UpDnL+1y1+QTcHFU7Z4DUwHB7wM
	c1hTwNjQ1rryr5JxRfvOAT4ok+ND30h8u923xNdugUppBk8y8OGEVYbtF6PG4kkq+vCStNOidPh
	HFc0136Tr5jynraIjVL7noWvvA/Vr8hekbgPmkhBeUVcZWg5D97Bg7Xdzgco+u9tC1HaqW0OBsP
	eUG
X-Received: by 2002:a05:6808:3447:b0:467:eccb:b788 with SMTP id 5614622812f47-467eccbb9fcmr2193790b6e.9.1774049985913;
        Fri, 20 Mar 2026 16:39:45 -0700 (PDT)
Received: from [172.26.252.3] (97-118-253-141.hlrn.qwest.net. [97.118.253.141])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14ddbcb3sm3398708fac.14.2026.03.20.16.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 16:39:45 -0700 (PDT)
Message-ID: <336649dc-b99f-4e1c-b23d-c9520187c7b0@gmail.com>
Date: Fri, 20 Mar 2026 17:39:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Scott Murray <scott.murray@konsulko.com>, rybczynska@gmail.com,
 yocto-patches@lists.yoctoproject.org
Cc: Yash.Shinde@windriver.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH 0/1] suricata: update 7.0.13 -> 8.0.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Mar 2026 23:39:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3531

Tested against:
Poky - 6.0 M2
Image - core-image-selinux
Target - qemuarm64 (2 GB RAM)

Previous results (7.0.12):
https://lists.yoctoproject.org/g/yocto-patches/topic/116119035

Tooling note:
update_crates behaves much better.
I only had to add SRC_URI checksums (prompted).

Target testing:
```
root@qemuarm64:~# systemctl status suricata
* suricata.service - Suricata IDS/IDP daemon
     Loaded: loaded (/usr/lib/systemd/system/suricata.service; enabled; preset: enabled)
     Active: active (running) since Fri 2026-03-20 22:23:37 UTC; 21s ago
 Invocation: 0a0439fe27d84ec19eaff6f718822f53
       Docs: man:suricata(8)
             man:suricatasc(8)
             https://redmine.openinfosecfoundation.org/projects/suricata/wiki
   Main PID: 489 (Suricata-Main)
      Tasks: 10 (limit: 296)
     Memory: 63.2M (peak: 64.6M)
        CPU: 1.732s
     CGroup: /system.slice/suricata.service
             `-489 /usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0

Mar 20 22:23:37 qemuarm64 systemd[1]: Started Suricata IDS/IDP daemon.
Mar 20 22:23:38 qemuarm64 suricata[489]: i: suricata: This is Suricata version 8.0.4 RELEASE running in SYSTEM mode
Mar 20 22:23:38 qemuarm64 suricata[489]: W: detect: No rule files match the pattern /var/lib/suricata/rules/suricata.rules
Mar 20 22:23:38 qemuarm64 suricata[489]: W: detect: 1 rule files specified, but no rules were loaded!
Mar 20 22:23:38 qemuarm64 suricata[489]: i: threads: Threads created -> W: 4 FM: 1 FR: 1   Engine started.

root@qemuarm64:~# suricata-update
20/3/2026 -- 22:28:36 - <Info> -- Using data-directory /var/lib/suricata.
20/3/2026 -- 22:28:36 - <Info> -- Using Suricata configuration /etc/suricata/suricata.yaml
20/3/2026 -- 22:28:36 - <Info> -- Using /usr/share/suricata/rules for Suricata provided rules.
20/3/2026 -- 22:28:36 - <Info> -- Found Suricata version 8.0.4 at /bin/suricata.
20/3/2026 -- 22:28:36 - <Info> -- Loading /etc/suricata/suricata.yaml
20/3/2026 -- 22:28:36 - <Info> -- Disabling rules for protocol pgsql
20/3/2026 -- 22:28:36 - <Info> -- Disabling rules for protocol modbus
20/3/2026 -- 22:28:36 - <Info> -- Disabling rules for protocol dnp3
20/3/2026 -- 22:28:36 - <Info> -- Disabling rules for protocol enip
20/3/2026 -- 22:28:36 - <Info> -- No sources configured, will use Emerging Threats Open
20/3/2026 -- 22:28:36 - <Info> -- Fetching https://rules.emergingthreats.net/open/suricata-8.0.4/emerging.rules.tar.gz.
 100% - 5398510/5398510
20/3/2026 -- 22:28:37 - <Info> -- Done.
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/app-layer-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/decoder-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dhcp-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dnp3-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dns-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/files.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/http2-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/http-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ipsec-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/kerberos-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/modbus-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/mqtt-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/nfs-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ntp-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/quic-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/rfb-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/smb-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/smtp-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ssh-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/stream-events.rules
20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/tls-events.rules
20/3/2026 -- 22:28:39 - <Info> -- Ignoring file e8e18dbaadbcd7eebb54ecdb5c78f603/rules/emerging-deleted.rules
20/3/2026 -- 22:29:04 - <Info> -- Loaded 65077 rules.
20/3/2026 -- 22:29:08 - <Info> -- Disabled 15 rules.
20/3/2026 -- 22:29:08 - <Info> -- Enabled 0 rules.
20/3/2026 -- 22:29:08 - <Info> -- Modified 0 rules.
20/3/2026 -- 22:29:08 - <Info> -- Dropped 0 rules.
20/3/2026 -- 22:29:10 - <Info> -- Enabled 136 rules for flowbit dependencies.
20/3/2026 -- 22:29:10 - <Info> -- Creating directory /var/lib/suricata/rules.
20/3/2026 -- 22:29:10 - <Info> -- Backing up current rules.
20/3/2026 -- 22:29:10 - <Info> -- Writing rules to /var/lib/suricata/rules/suricata.rules: total: 65077; enabled: 49217; added: 65077; removed 0; modified: 0
20/3/2026 -- 22:29:11 - <Info> -- Writing /var/lib/suricata/rules/classification.config
20/3/2026 -- 22:29:12 - <Info> -- Testing with suricata -T.
20/3/2026 -- 22:29:54 - <Info> -- Done.

root@qemuarm64:~# systemctl restart suricata

root@qemuarm64:~# systemctl status suricata
* suricata.service - Suricata IDS/IDP daemon
     Loaded: loaded (/usr/lib/systemd/system/suricata.service; enabled; preset: enabled)
     Active: active (running) since Fri 2026-03-20 22:30:33 UTC; 59s ago
 Invocation: a95034e5d76f418fa530bcb8027f0183
       Docs: man:suricata(8)
             man:suricatasc(8)
             https://redmine.openinfosecfoundation.org/projects/suricata/wiki
   Main PID: 623 (Suricata-Main)
      Tasks: 10 (limit: 2406)
     Memory: 1.1G (peak: 1.1G)
        CPU: 38.435s
     CGroup: /system.slice/suricata.service
             `-623 /usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0

Mar 20 22:30:33 qemuarm64 systemd[1]: Started Suricata IDS/IDP daemon.
Mar 20 22:30:34 qemuarm64 suricata[623]: i: suricata: This is Suricata version 8.0.4 RELEASE running in SYSTEM mode
Mar 20 22:31:11 qemuarm64 suricata[623]: i: threads: Threads created -> W: 4 FM: 1 FR: 1   Engine started.

root@qemuarm64:~# wget -O /tmp/arst http://testmynids.org/uid/index.html
Connecting to testmynids.org (18.238.176.2:80)
[...]
'/tmp/arst' saved

root@qemuarm64:~# tail /var/log/suricata/fast.log
03/20/2026-22:31:56.562766  [**] [1:2100498:7] GPL ATTACK_RESPONSE id check returned root [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 18.238.176.2:80 -> 10.0.2.15:38026

root@qemuarm64:~# suricatactl -h
Usage: suricatactl [OPTIONS] <COMMAND>

Commands:
  filestore  Filestore management commands
  help       Print this message or the help of the given subcommand(s)

Options:
  -v, --verbose...
  -q, --quiet       Quiet mode, only warnings and errors will be logged
  -h, --help        Print help

root@qemuarm64:~# suricatasc -h
Usage: suricatasc [OPTIONS] [SOCKET]

Arguments:
  [SOCKET]  Optional path to Suricata unix socket

Options:
  -v, --verbose            Enable verbose output
  -c, --command <COMMAND>  Execute command and return JSON
  -h, --help               Print help

root@qemuarm64:~# journalctl -u suricata -p notice
-- No entries --
```

Clayton Casciato (1):
  suricata: update 7.0.13 -> 8.0.4

 ...kefile-from-using-its-own-rust-steps.patch |   36 +-
 recipes-ids/suricata/libhtp_0.5.52.bb         |   23 -
 recipes-ids/suricata/suricata-crates.inc      | 3282 +++++++++++++----
 .../{suricata_7.0.13.bb => suricata_8.0.4.bb} |   22 +-
 4 files changed, 2673 insertions(+), 690 deletions(-)

