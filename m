Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9317.1795883248495689490
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:27:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=pL4JhFeG;
 spf=pass (domain: konsulko.com, ip: 209.85.128.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so74119805e9.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795883247; x=1796488047; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RZLBtS89FSx0++xuJuRm41ybF7GMAz0Jxg4/zLbb/zk=;
        b=pL4JhFeGrnvWrokEIT4dAJJgOuabbujPKGhYQTEyAOzpdQju9wDpkS+PbeqsuqO38l
         3cqI/7p9KPfjAktMbDCMjXs3CJeWROC7TAB0FgIGD9plZsyiJUhq2aDvKR47tV5qWo0U
         bt1pypwGT2v/8xGzFpfU7dMy5wkbDUEJlGetE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795883247; x=1796488047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RZLBtS89FSx0++xuJuRm41ybF7GMAz0Jxg4/zLbb/zk=;
        b=SjyX1vyL13x32n6Bc1cLP4pNk+UGPAtr68GdsI9uUSKI70r/SKidUblQfYSFT8Rb+R
         HJpwPLYxYugojp0Q5nxWuXgOl0GIMKzaZ51TeZ9qguOipNgzYqJXZ0z4bquqIxxjKh0a
         CWvcLwBl3gzeqMOWZkCv7TsD0ew1fWgDXBWekDm5AAnl0/W945GjLkSu/iKBFPGm8h54
         yM0v2/Ww58RKGClGcxPihAKve+Y7nlOp9H3Zaxs2d3NyvmU/6Hlo2zj3UI6RenuCE7On
         7Fqld0fJ2IWUCLpDZvgiYWjRzADrd2WnUFc9NsKOZyBUKmeAVNDipmxV5U0nu5pDGPrf
         fgqA==
X-Gm-Message-State: APuU4Z/cCushTASjpb1pNpkgFM5l9Uts6Zxz9zdjq8517hJNDmFOa+Jz
	W2rnmpRAht5CqOAWJ1j5eKHGQNS13KeqtyuMJe+KKu0LIUboUldF21XaiKfIcOItNwwFEem2rXq
	so7AT
X-Gm-Gg: AZFdTZeyQ4DfBvwrhSaUIWPkt+R5DGwjmnrm94o9u7ehu+7WHqRwPqKPlpNw7c7rRhG
	Cjz93bO0Efsx7rR4HaXG4gSOXgaBaFeva4nChcmlauo4oqQGVMYIJzTCjZ8sLc9xdfHf/lPAv46
	OcpVCjJAqV5Kt1dBXvxZV4lrkmh+xjon+1TRYP7FGyzqSivs6HwFpoMmB2uIry1fADbH5MSg/A7
	NzAKaWbu24Lt1b25d/vS0yuX0nSBC1xvD1DuNqP+EcsqJuyByhGKZ26YTB7Co+G6/Cfdg8PPr5Q
	kk/J1sOb5JRw7xP4UYIZnxOO+sbB90RfCMh8BY9i/a7nEWanJcyGLNFjWFx5xr0Y2mGzr6BylkX
	Lvqw74SbvTtDv3e3/EekKX/qXmq1Vfl6RYAm5x0ZcUzq5ujPq5DjGj1m9EeWBc1ngke8gvwyAa/
	6sIXUSKBA50+yaPPjMY85EDYbvLstGaLnMjkcQ1b9DqanCggH5zROWHPdYB+LAl931u7B+gg6zG
	bdod5MUgr4OgphzUtdCGgWvrc5HhQyG5rQcrnBirgXLq+JTGy/5AB8SufYh5sjGS45Tgd/gV1wy
	ta7CyjZquLfBqrsiyl059xmipBjfKd8/GqphfGVEgu8vjKWXf8X7P65mnoPnbZwD1eQ/sd3SAy2
	/aU8V8M92C5t1cAycARxUVDJLSlCiqCCp4Sj8qGlEE/dYtZXqKu8=
X-Received: by 2002:a05:600c:64c8:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4bb887e2380mr520781795e9.4.1795883246300;
        Sat, 28 Nov 2026 08:27:26 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm529202045e9.1.2026.11.28.08.27.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:27:25 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 00/10] Assorted updates 11/28
Date: Sat, 28 Nov 2026 18:27:03 +0200
Message-ID: <cover.1795882913.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:27:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5559
Content-Type: text/plain; charset="utf-8"

This series rolls up recent contributions along with a handful of
package updates and a build fix from myself.  I have pushed them
to master-next, and plan to merge them sometime on Tuesday, Dec. 1,
if there are no objections.

Scott


Changes:

Francesco Dolcini (1):
  systemd: do not enable efi for tpm2

Niranjan Reddy Mekala (2):
  swtpm: upgrade 0.10.0 -> 0.10.2
  swtpm: backport sysusers and tmpfiles support

Scott Murray (7):
  parsec-tool: Fix building with Rust 1.100
  suricata: Upgrade 8.0.6 -> 8.0.8
  python3-suricata-update: Upgrade 1.3.6 -> 1.3.8
  crowdsec: Upgrade 1.8.1 -> 1.8.2
  aide: Upgrade 0.19.4 -> 0.19.5
  sssd: Upgrade 2.13.1 -> 2.13.2
  ding-libs: Update LIC_FILES_CHKSUM

 .../sssd/{sssd_2.13.1.bb => sssd_2.13.2.bb}   |   2 +-
 .../0001-Update-picky-asn1-x509-version.patch |  47 +++++
 .../parsec-tool/parsec-tool-crates.inc        |   4 +-
 .../parsec-tool/parsec-tool_0.7.0.bb          |   1 +
 .../recipes-core/systemd/systemd_%.bbappend   |   2 +-
 ...ll-sysusers.d-and-tmpfiles.d-configs.patch |  86 ++++++++
 ...2-swtpm-sync-sysuser.d-with-tpm2-tss.patch |  29 +++
 .../{swtpm_0.10.0.bb => swtpm_0.10.2.bb}      |  11 +-
 .../aide/{aide_0.19.4.bb => aide_0.19.5.bb}   |   2 +-
 recipes-ids/crowdsec/crowdsec-go-mods.inc     | 185 +++++++++--------
 recipes-ids/crowdsec/crowdsec-licenses.inc    | 194 +++++++++---------
 .../{crowdsec_1.8.1.bb => crowdsec_1.8.2.bb}  |   2 +-
 ....6.bb => python3-suricata-update_1.3.8.bb} |   2 +-
 recipes-ids/suricata/suricata-crates.inc      | 101 +++++----
 .../{suricata_8.0.6.bb => suricata_8.0.8.bb}  |   2 +-
 recipes-security/ding-libs/ding-libs_0.7.0.bb |   3 +-
 16 files changed, 423 insertions(+), 250 deletions(-)
 rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.13.1.bb => sssd_2.13.2.bb} (98%)
 create mode 100644 meta-parsec/recipes-parsec/parsec-tool/files/0001-Update-picky-asn1-x509-version.patch
 create mode 100644 meta-tpm/recipes-tpm/swtpm/swtpm/0001-swtpm-install-sysusers.d-and-tmpfiles.d-configs.patch
 create mode 100644 meta-tpm/recipes-tpm/swtpm/swtpm/0002-swtpm-sync-sysuser.d-with-tpm2-tss.patch
 rename meta-tpm/recipes-tpm/swtpm/{swtpm_0.10.0.bb => swtpm_0.10.2.bb} (84%)
 rename recipes-ids/aide/{aide_0.19.4.bb => aide_0.19.5.bb} (96%)
 rename recipes-ids/crowdsec/{crowdsec_1.8.1.bb => crowdsec_1.8.2.bb} (96%)
 rename recipes-ids/suricata/{python3-suricata-update_1.3.6.bb => python3-suricata-update_1.3.8.bb} (90%)
 rename recipes-ids/suricata/{suricata_8.0.6.bb => suricata_8.0.8.bb} (98%)

-- 
2.47.3

