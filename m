Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DD3FAD3F7
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 03:41:16 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9530.1776915645918848962
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Apr 2026 20:40:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TsNa81sR;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7de46b8e432so519773a34.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 20:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776915645; x=1777520445; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfRQUtAUKDTj+M+3yDYEKKT4sUH8+ZiuiF+oFmLyh10=;
        b=TsNa81sRWEEgZ/FYQGjxAj9FCsS+EweIHZZgyCiuZ8T+uppB1A1zV2d2US8tDxU/Me
         HOIZy/b78KAOSZxGQ5mcDb67md/CcOgRmXYX8zvfaj82CLtVXteCqEpZ89OKQU33jHoT
         GTla/LdCieu5RYsg373HiPUTQ+C1Zxon3PjHsujaX+MxiFXixk7pj3ID6CACb6Ipp/rh
         3PU8yCBgeIGHBNaoLtx0uWfFAhPIZ3AgFSLmOIay8+zXQ+P59DJQCt3PmablqNms63vM
         nvAohKLGcEupairoBe9IVkva2GZjb23ZuTRTEfIORCJFxwnkbYnezPhO8BQygr1kdtae
         wNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776915645; x=1777520445;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BfRQUtAUKDTj+M+3yDYEKKT4sUH8+ZiuiF+oFmLyh10=;
        b=SAIQKLAOFNGZAQcid7N6p2Bs9N9Uu5DR6m32nT9+YD6RZYz+TK0ON/FCCZGm4kUyuh
         cF2fMMUXftOCuQpwvWRlM/+pzEWVHXwfHqeyAhox8axbAMIsom+oYwA+U/Ui1LCX79og
         1ZGv0+FAoV7X/BOECDAt6nCqBEx9rDb57o2jUSVj+yBDBkSa4qytyxjIuYTbl7kINq3G
         1zuJey64tru8dkb7PDTqlOP+qayuLP+hqQPs1PDAmDX1+yKNVfMezaeKRbBjYx5mlGqx
         zszg3fVdMWFz50QbTMLdoRd8jVQfwU0KLXM8WDqBurVewmuq/HDuIWPTaWda0BBzD12l
         tMhw==
X-Forwarded-Encrypted: i=1; AFNElJ9Nt4VC7kK+Vyu/WDggerQqgfDn+LyRL+/oo8YoP7RPXsPHxaJiIkfQLk0eJsTmbux/1bte6ucNEWz1WKol@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzYpshJowwgQxL6nUMm0PxnORLIIZkWeM88edyKVTsqoxHDJZ/L
	Bt6+FJKR6azjpt16/SAWfCFY0n0+B+rzj2MMZBvbR24s7WwaDhSbNFin
X-Gm-Gg: AeBDiesVWrjxMu7Le+mfQfFtHdhQHakOeBpe/2kOlWtlQYdPXpTG2lx7utPoPkYnFUo
	6h94FY9kGFplvbvP02xW3b1X4Ct2R11ir7kkek4SQ+RpkAAgu0VlDdEAAPLdc+KkCQVCS3X41kk
	954il9r2wsoZ4TYZPsV+qod38iwABL95St8Rz4vjutUmBewKfWnB7CskVz4QKj3I1COoQcNbCZM
	fdeotGTTUUTHdsMOUvvGygjV8zEUzUrqruKPyvJ7dNZWnKqnddU5PY7nSsSE+y8kDsPK2YQwsW4
	WKqyWA0s9xUTIyfETmfOlmSO+lUmHFpB0fWVeStuwILzqvI6ZKciKsrcJxsZrT+x6ZMG5c+yDGT
	VJpcSLu20F83dXd1AY++jWFa6U24cqIu++l7Pg3Plb5it3mJ5X8chEEYZ0qN5hU5PvM0akv5m7G
	h4UZesc4JsG4ljBE+0D0K6Ru/sd2eluuXFteS9PwcxJx92wuKa3tW+K2uSlYkLQZfPBx81m5dfJ
	/pobT3F5v4BQ3E=
X-Received: by 2002:a05:6830:43ac:b0:7dc:cd0b:58ba with SMTP id 46e09a7af769-7dccd0b6c6dmr9946895a34.4.1776915644985;
        Wed, 22 Apr 2026 20:40:44 -0700 (PDT)
Received: from [172.26.252.3] (97-118-253-141.hlrn.qwest.net. [97.118.253.141])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dce6a9405asm3600968a34.5.2026.04.22.20.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 20:40:44 -0700 (PDT)
Message-ID: <4e044d75-6915-4b1b-a4f7-c66d3262c874@gmail.com>
Date: Wed, 22 Apr 2026 21:40:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH v2 0/1] suricata: update 7.0.13 -> 8.0.4
To: Scott Murray <scott.murray@konsulko.com>, rybczynska@gmail.com,
 yocto-patches@lists.yoctoproject.org
Cc: Yash.Shinde@windriver.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 03:41:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3765

v1: https://lists.yoctoproject.org/g/yocto-patches/topic/meta_security_patch_0_1/118427566

core-image-selinux against 6.0 M3 + OE-C head for:
https://lists.openembedded.org/g/openembedded-core/message/235507

Build Configuration:
BB_VERSION           = "2.16.0"
BUILD_SYS            = "x86_64-linux"
NATIVELSBSTRING      = "universal"
TARGET_SYS           = "aarch64-poky-linux"
MACHINE              = "qemuarm64"
SDKMACHINE           = "x86_64"
DISTRO               = "poky"
DISTRO_VERSION       = "5.3.99+snapshot-9a83f0878b6bacbc7b322cfec076b4e79ad7b8fb"
TUNE_FEATURES        = "aarch64 crc cortexa57"
meta                 = "master:9a83f0878b6bacbc7b322cfec076b4e79ad7b8fb"
meta-yocto-bsp       
meta-poky            = "master:49cbb01d52521bfe557395c9ebfae6b1c162581e"
meta-cc              = "master:73bfa59fcdc619194cb01226a22167e12dd55b6e"
meta-selinux         = "master:f7306d7af4425553684a860df6f6d0ee66efba31"
meta-security        = "master:bd6927e1dfc19b2b9619da85e03fb06b6fb6dc03"
meta-python          
meta-oe              = "master:d793c367e067c49956d38caf6eb84cb112c9c9b7"

Post-build QEMU configuration:
build/tmp/deploy/images/qemuarm64$ sed -i 's/qb_mem = -m 256/qb_mem = -m 2048/' *.qemuboot.conf

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
     Active: active (running) since Wed 2026-04-22 22:48:43 UTC; 23s ago
 Invocation: 94ff4988fa924eaab4b5b6f0be2e1783
       Docs: man:suricata(8)
             man:suricatasc(8)
             https://redmine.openinfosecfoundation.org/projects/suricata/wiki
   Main PID: 463 (Suricata-Main)
      Tasks: 10 (limit: 2406)
     Memory: 74.1M (peak: 74.5M)
        CPU: 1.671s
     CGroup: /system.slice/suricata.service
             `-463 /usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0

Apr 22 22:48:43 qemuarm64 systemd[1]: Started Suricata IDS/IDP daemon.
Apr 22 22:48:43 qemuarm64 suricata[463]: i: suricata: This is Suricata version 8.0.4 RELEASE running in SYSTEM mode
Apr 22 22:48:44 qemuarm64 suricata[463]: W: detect: No rule files match the pattern /var/lib/suricata/rules/suricata.rules
Apr 22 22:48:44 qemuarm64 suricata[463]: W: detect: 1 rule files specified, but no rules were loaded!
Apr 22 22:48:44 qemuarm64 suricata[463]: i: threads: Threads created -> W: 4 FM: 1 FR: 1   Engine started.

root@qemuarm64:~# suricata-update
22/4/2026 -- 22:49:30 - <Info> -- Using data-directory /var/lib/suricata.
22/4/2026 -- 22:49:30 - <Info> -- Using Suricata configuration /etc/suricata/suricata.yaml
22/4/2026 -- 22:49:30 - <Info> -- Using /usr/share/suricata/rules for Suricata provided rules.
22/4/2026 -- 22:49:30 - <Info> -- Found Suricata version 8.0.4 at /bin/suricata.
22/4/2026 -- 22:49:30 - <Info> -- Loading /etc/suricata/suricata.yaml
22/4/2026 -- 22:49:30 - <Info> -- Disabling rules for protocol pgsql
22/4/2026 -- 22:49:30 - <Info> -- Disabling rules for protocol modbus
22/4/2026 -- 22:49:30 - <Info> -- Disabling rules for protocol dnp3
22/4/2026 -- 22:49:30 - <Info> -- Disabling rules for protocol enip
22/4/2026 -- 22:49:30 - <Info> -- No sources configured, will use Emerging Threats Open
22/4/2026 -- 22:49:30 - <Info> -- Fetching https://rules.emergingthreats.net/open/suricata-8.0.4/emerging.rules.tar.gz.
 100% - 5439551/5439551
22/4/2026 -- 22:49:31 - <Info> -- Done.
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/app-layer-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/decoder-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dhcp-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dnp3-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/dns-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/files.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/http2-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/http-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ipsec-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/kerberos-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/modbus-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/mqtt-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/nfs-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ntp-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/quic-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/rfb-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/smb-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/smtp-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/ssh-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/stream-events.rules
22/4/2026 -- 22:49:31 - <Info> -- Loading distribution rule file /usr/share/suricata/rules/tls-events.rules
22/4/2026 -- 22:49:33 - <Info> -- Ignoring file e8e18dbaadbcd7eebb54ecdb5c78f603/rules/emerging-deleted.rules
22/4/2026 -- 22:49:56 - <Info> -- Loaded 65682 rules.
22/4/2026 -- 22:49:59 - <Info> -- Disabled 15 rules.
22/4/2026 -- 22:49:59 - <Info> -- Enabled 0 rules.
22/4/2026 -- 22:49:59 - <Info> -- Modified 0 rules.
22/4/2026 -- 22:49:59 - <Info> -- Dropped 0 rules.
22/4/2026 -- 22:50:01 - <Info> -- Enabled 136 rules for flowbit dependencies.
22/4/2026 -- 22:50:01 - <Info> -- Creating directory /var/lib/suricata/rules.
22/4/2026 -- 22:50:01 - <Info> -- Backing up current rules.
22/4/2026 -- 22:50:01 - <Info> -- Writing rules to /var/lib/suricata/rules/suricata.rules: total: 65682; enabled: 49815; added: 65682; removed 0; modified: 0
22/4/2026 -- 22:50:02 - <Info> -- Writing /var/lib/suricata/rules/classification.config
22/4/2026 -- 22:50:03 - <Info> -- Testing with suricata -T.
22/4/2026 -- 22:50:44 - <Info> -- Done.

root@qemuarm64:~# systemctl restart suricata

root@qemuarm64:~# systemctl status suricata
* suricata.service - Suricata IDS/IDP daemon
     Loaded: loaded (/usr/lib/systemd/system/suricata.service; enabled; preset: enabled)
     Active: active (running) since Wed 2026-04-22 22:51:35 UTC; 1min 8s ago
 Invocation: 6a8f6ccd61fc4872be2a3d4b61e403f5
       Docs: man:suricata(8)
             man:suricatasc(8)
             https://redmine.openinfosecfoundation.org/projects/suricata/wiki
   Main PID: 600 (Suricata-Main)
      Tasks: 10 (limit: 2406)
     Memory: 1.1G (peak: 1.2G)
        CPU: 40.058s
     CGroup: /system.slice/suricata.service
             `-600 /usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0

Apr 22 22:51:35 qemuarm64 systemd[1]: Started Suricata IDS/IDP daemon.
Apr 22 22:51:35 qemuarm64 suricata[600]: i: suricata: This is Suricata version 8.0.4 RELEASE running in SYSTEM mode
Apr 22 22:52:14 qemuarm64 suricata[600]: i: threads: Threads created -> W: 4 FM: 1 FR: 1   Engine started.

root@qemuarm64:~# wget -O /tmp/arst http://testmynids.org/uid/index.html
Connecting to testmynids.org (18.238.176.2:80)
saving to '/tmp/arst'
[...]
'/tmp/arst' saved

root@qemuarm64:~# tail /var/log/suricata/fast.log
04/22/2026-22:53:09.465216  [**] [1:2100498:7] GPL ATTACK_RESPONSE id check returned root [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 18.238.176.2:80 -> 10.0.2.15:43914

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
 .../{suricata_7.0.13.bb => suricata_8.0.4.bb} |   30 +-
 4 files changed, 2680 insertions(+), 691 deletions(-)

