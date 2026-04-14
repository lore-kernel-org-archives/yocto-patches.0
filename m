Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFD7F9D0F8
	for <webhook@archiver.kernel.org>; Tue, 14 Apr 2026 21:37:23 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5585.1776202633736385436
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Apr 2026 14:37:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=sfNwk7sJ;
 spf=pass (domain: konsulko.com, ip: 209.85.160.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d6b9bca48so79161431cf.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1776202632; x=1776807432; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+hmiR98zs8khf2UZwJn51WtzYEb57dM2Lpl/EJgEtw=;
        b=sfNwk7sJKenz7imhGkHNw6AvY80VnxQ6aVSrwLvRUVKPoyJMM14+wegKGoLklpaSv+
         LNtuT9Giva7+KUa1XVmimFkJyItYt6T15AZdlZX4GCLammT7jD1qbeTbO46ec9mJNW8T
         HvdZkOjEHRu5DU1XDGfi91d+W492SgSmYs24A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776202632; x=1776807432;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+hmiR98zs8khf2UZwJn51WtzYEb57dM2Lpl/EJgEtw=;
        b=Qm+gPjGstP9HrIB9j0KK3b8FTIpSvWrrmqT+xhQa72BIR+kCAXBdD9xPDgUeIFvUmb
         +9n9ZY7sqld2OWtBOycvlSX1MUvg4HqMKdTwH0IbjzgQYahu248CUqgtUqsTobB/b5RE
         bPL5lnA8jTU51FrVgIi5k2aP1A/uVsAbgwm9WhXXVs0XlCzj4vfgcruttIa+h1VgEfIz
         AGvzPehbJfHz5Bi4duljFkP52JDdaGg++eXdVzA+54z3qXydy/yhYI1S8iGaRYWuXT/L
         Y44vxZgtH/XR1CKioqH8ctvsoUkNJCRd4qmbWoS/Cmam1TO48OwouEcimEIYc85AN+PW
         NhaA==
X-Forwarded-Encrypted: i=1; AFNElJ990+uY52QXhJOselyVPrr6O/uwiema1AV6vRQcDJiccOBg8mB5C4U/z4iPXqylp8KFPN8SYDKKoPJaAmLh@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxFHbfxoOYd8BC9nd8+Iz56BCC4EeyiB85FLQPm01ZznUf0JpBp
	U/29BngJ1TwDm+2bsIUiZ9beEzHbJNIeN3lVP5YRR9z2h/WBF6mo+kkyJ9ZThRHgDCw=
X-Gm-Gg: AeBDievXt+XS9XUptEpe1DxiXJnQsfscyEqPtGayW+DWcT9A6vHasRBCAfe067jo5ts
	iN7QuoT3TKJgnBXzVUACJK5Jwdn26b+OusQCP8C9t2zPwi0AeJDlw1VsjLZmFAySjkXhITWF4MP
	YYgl8aaqCP2+FvfR7b1TEGagenHDK95BS1ip0BubB9dBXPgLDcOab2tBUFTud2nQId0jXTW9bW4
	eq/ulj8PxvZLl1wH99XPFD96Xzt/eIws9WV5gvYHplzsoQnS/MaQv5vxKu3xp4soip8h2nmii3L
	Bv8VwOS45p1nPOV8zXNj33u0n81iEiGGlDiF+zzfRUABxk7NA24qlqCDV1apMh15ANGfn+Y1D7k
	5DLhCnH3W+3lq5FhNAdsgnA7ywVXSphWusOGDKNtMOn/kM0uzy6udKMJpNOaRjf8wD1wRrqUlvU
	1iNCRV36wY5cPWWjBM+DCEkkXb30vV6V3u98TNKmi0TpmVZubXIl5CCfn4LIOf4xDjUwLDimq/t
	czlDmNc6NxZEk7N+hjS6P/R7CtJGvxElem7sV+vkZrYuWI=
X-Received: by 2002:a05:622a:96:b0:50d:a9a9:fbfa with SMTP id d75a77b69052e-50dd5cf56edmr275781881cf.43.1776202632212;
        Tue, 14 Apr 2026 14:37:12 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd525fa23sm136654061cf.0.2026.04.14.14.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 14:37:11 -0700 (PDT)
Date: Tue, 14 Apr 2026 17:37:10 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: Clayton Casciato <majortomtosourcecontrol@gmail.com>
cc: rybczynska@gmail.com, yocto-patches@lists.yoctoproject.org, 
    Yash.Shinde@windriver.com
Subject: Re: [meta-security][PATCH 0/1] suricata: update 7.0.13 -> 8.0.4
In-Reply-To: <336649dc-b99f-4e1c-b23d-c9520187c7b0@gmail.com>
Message-ID: <bef0bbaa-1a32-aaed-52ca-34f007504510@konsulko.com>
References: <336649dc-b99f-4e1c-b23d-c9520187c7b0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 21:37:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3703

On Fri, 20 Mar 2026, Clayton Casciato wrote:

> Tested against:
> Poky - 6.0 M2
> Image - core-image-selinux
> Target - qemuarm64 (2 GB RAM)
>
> Previous results (7.0.12):
> https://lists.yoctoproject.org/g/yocto-patches/topic/116119035
>
> Tooling note:
> update_crates behaves much better.
> I only had to add SRC_URI checksums (prompted).

It looks like the Lua 5.5.0 upgrade in oe-core has non-trivially broken
the 8.0.x suricata build.  There's a somewhat straightforward issue with
a new argument to lua_newstate, but after that there are link errors that
the more I poked around the more I'm thinking there's some oddness wrt
their vendoring a copy of Lua (5.4.8) for the Rust side of things.  I
don't see any signs of the build process for the .c files under src
pointing at that source, but then AFAICT everything kind of gets lumped
together when linking the final suricata binary...  If you have the time
to try to untangle this, please do so, as I cannot guarantee that I get
to it in the next week or two.

Thanks,

Scott


> Target testing:
> ```
> root@qemuarm64:~# systemctl status suricata
> * suricata.service - Suricata IDS/IDP daemon
>      Loaded: loaded (/usr/lib/systemd/system/suricata.service; enabled; preset: enabled)
>      Active: active (running) since Fri 2026-03-20 22:23:37 UTC; 21s ago
>  Invocation: 0a0439fe27d84ec19eaff6f718822f53
>        Docs: man:suricata(8)
>              man:suricatasc(8)
>              https://redmine.openinfosecfoundation.org/projects/suricata/wiki
>    Main PID: 489 (Suricata-Main)
>       Tasks: 10 (limit: 296)
>      Memory: 63.2M (peak: 64.6M)
>         CPU: 1.732s
>      CGroup: /system.slice/suricata.service
>              `-489 /usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0
>
> Mar 20 22:23:37 qemuarm64 systemd[1]: Started Suricata IDS/IDP daemon.
> Mar 20 22:23:38 qemuarm64 suricata[489]: i: suricata: This is Suricata version 8.0.4 RELEASE running in SYSTEM mode
> Mar 20 22:23:38 qemuarm64 suricata[489]: W: detect: No rule files match the pattern /var/lib/suricata/rules/suricata.rules
> Mar 20 22:23:38 qemuarm64 suricata[489]: W: detect: 1 rule files specified, but no rules were loaded!
> Mar 20 22:23:38 qemuarm64 suricata[489]: i: threads: Threads created -> W: 4 FM: 1 FR: 1   Engine started.
>
> root@qemuarm64:~# suricata-update
> 20/3/2026 -- 22:28:36 - <Info> -- Using data-directory /var/lib/suricata.
> 20/3/2026 -- 22:28:36 - <Info> -- Using Suricata configuration /etc/suricata/suricata.yaml
> 20/3/2026 -- 22:28:36 - <Info> -- Using /usr/share/suricata/rules for Suricata provided rules.
> 20/3/2026 -- 22:28:36 - <Info> -- Found Suricata version 8.0.4 at /bin/suricata.
> 20/3/2026 -- 22:28:36 - <Info> -- Loading /etc/suricata/suricata.yaml
> 20/3/2026 -- 22:28:36 - <Info> -- Disabling rules for protocol pgsql
> 20/3/2026 -- 22:28:36 - <Info> -- Disabling rules for protocol modbus
> 20/3/2026 -- 22:28:36 - <Info> -- Disabling rules for protocol dnp3
> 20/3/2026 -- 22:28:36 - <Info> -- Disabling rules for protocol enip
> 20/3/2026 -- 22:28:36 - <Info> -- No sources configured, will use Emerging Threats Open
> 20/3/2026 -- 22:28:36 - <Info> -- Fetching https://rules.emergingthreats.net/open/suricata-8.0.4/emerging.rules.tar.gz.
>  100% - 5398510/5398510
> 20/3/2026 -- 22:28:37 - <Info> -- Done.
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/app-layer-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/decoder-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dhcp-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dnp3-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dns-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/files.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/http2-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/http-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ipsec-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/kerberos-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/modbus-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/mqtt-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/nfs-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ntp-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/quic-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/rfb-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/smb-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/smtp-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ssh-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/stream-events.rules
> 20/3/2026 -- 22:28:37 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/tls-events.rules
> 20/3/2026 -- 22:28:39 - <Info> -- Ignoring file e8e18dbaadbcd7eebb54ecdb5c78f603/rules/emerging-deleted.rules
> 20/3/2026 -- 22:29:04 - <Info> -- Loaded 65077 rules.
> 20/3/2026 -- 22:29:08 - <Info> -- Disabled 15 rules.
> 20/3/2026 -- 22:29:08 - <Info> -- Enabled 0 rules.
> 20/3/2026 -- 22:29:08 - <Info> -- Modified 0 rules.
> 20/3/2026 -- 22:29:08 - <Info> -- Dropped 0 rules.
> 20/3/2026 -- 22:29:10 - <Info> -- Enabled 136 rules for flowbit dependencies.
> 20/3/2026 -- 22:29:10 - <Info> -- Creating directory /var/lib/suricata/rules.
> 20/3/2026 -- 22:29:10 - <Info> -- Backing up current rules.
> 20/3/2026 -- 22:29:10 - <Info> -- Writing rules to /var/lib/suricata/rules/suricata.rules: total: 65077; enabled: 49217; added: 65077; removed 0; modified: 0
> 20/3/2026 -- 22:29:11 - <Info> -- Writing /var/lib/suricata/rules/classification.config
> 20/3/2026 -- 22:29:12 - <Info> -- Testing with suricata -T.
> 20/3/2026 -- 22:29:54 - <Info> -- Done.
>
> root@qemuarm64:~# systemctl restart suricata
>
> root@qemuarm64:~# systemctl status suricata
> * suricata.service - Suricata IDS/IDP daemon
>      Loaded: loaded (/usr/lib/systemd/system/suricata.service; enabled; preset: enabled)
>      Active: active (running) since Fri 2026-03-20 22:30:33 UTC; 59s ago
>  Invocation: a95034e5d76f418fa530bcb8027f0183
>        Docs: man:suricata(8)
>              man:suricatasc(8)
>              https://redmine.openinfosecfoundation.org/projects/suricata/wiki
>    Main PID: 623 (Suricata-Main)
>       Tasks: 10 (limit: 2406)
>      Memory: 1.1G (peak: 1.1G)
>         CPU: 38.435s
>      CGroup: /system.slice/suricata.service
>              `-623 /usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0
>
> Mar 20 22:30:33 qemuarm64 systemd[1]: Started Suricata IDS/IDP daemon.
> Mar 20 22:30:34 qemuarm64 suricata[623]: i: suricata: This is Suricata version 8.0.4 RELEASE running in SYSTEM mode
> Mar 20 22:31:11 qemuarm64 suricata[623]: i: threads: Threads created -> W: 4 FM: 1 FR: 1   Engine started.
>
> root@qemuarm64:~# wget -O /tmp/arst http://testmynids.org/uid/index.html
> Connecting to testmynids.org (18.238.176.2:80)
> [...]
> '/tmp/arst' saved
>
> root@qemuarm64:~# tail /var/log/suricata/fast.log
> 03/20/2026-22:31:56.562766  [**] [1:2100498:7] GPL ATTACK_RESPONSE id check returned root [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 18.238.176.2:80 -> 10.0.2.15:38026
>
> root@qemuarm64:~# suricatactl -h
> Usage: suricatactl [OPTIONS] <COMMAND>
>
> Commands:
>   filestore  Filestore management commands
>   help       Print this message or the help of the given subcommand(s)
>
> Options:
>   -v, --verbose...
>   -q, --quiet       Quiet mode, only warnings and errors will be logged
>   -h, --help        Print help
>
> root@qemuarm64:~# suricatasc -h
> Usage: suricatasc [OPTIONS] [SOCKET]
>
> Arguments:
>   [SOCKET]  Optional path to Suricata unix socket
>
> Options:
>   -v, --verbose            Enable verbose output
>   -c, --command <COMMAND>  Execute command and return JSON
>   -h, --help               Print help
>
> root@qemuarm64:~# journalctl -u suricata -p notice
> -- No entries --
> ```
>
> Clayton Casciato (1):
>   suricata: update 7.0.13 -> 8.0.4
>
>  ...kefile-from-using-its-own-rust-steps.patch |   36 +-
>  recipes-ids/suricata/libhtp_0.5.52.bb         |   23 -
>  recipes-ids/suricata/suricata-crates.inc      | 3282 +++++++++++++----
>  .../{suricata_7.0.13.bb => suricata_8.0.4.bb} |   22 +-
>  4 files changed, 2673 insertions(+), 690 deletions(-)
>

