Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7624.1794702920554576606
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Nov 2026 16:35:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=C/riCllm;
 spf=pass (domain: gmail.com, ip: 209.85.216.49, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso2053641a91.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 16:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794702920; x=1795307720; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=79TcD/HhcdRWTl/cesxj0ZeL8cTO2z286HPwqjS03i0=;
        b=C/riCllmV+/Io5Ry/duvfyVZ4SRfJGuj7MsPfNoIrAeIQnHZgzIJUPxsjh7/MmREty
         yPhHP48Wr1Z8O9n/FQCUhTXhh4qdvrKAVsclhSlx5QfHSTXVc5woIHFsBAKKNtL+CyYt
         GtURaXVK9yP6BP010D1MrRxw2XrCo63Rt7odZW9pUSR8xIQh3MQ8paf/W6faq39GCLE+
         hdrWP59edHztfxo2YJ+DA+rMPw9hjzmXcihpiyccuIbpkfsVwc6dt93hHzgnqhpIKAVT
         EOAWUe0g4zxJqB/B7aEIrOgnXB97nC54VzWg44Pn/p9rkmny9plz1NWJKEbxBeawx76u
         Zj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702920; x=1795307720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=79TcD/HhcdRWTl/cesxj0ZeL8cTO2z286HPwqjS03i0=;
        b=RArOmcsRehLYagUx5qjIfcOgV2KAqW7JnfnJX9iLEFemEX86zS3xi7yxztsRm0WZ/A
         x/WTj5NxMRIqdJQwW5NemfGLNF5DFThcZ9/jcXzrx3TwLaLNKdJirYS+/xGSWD2zcslF
         ouJEtvS4QfwUrhRLLWvZ9Z0o1jYkS+3OEVkxpGL5LVN5DOvMT6YhOpTXYhq5dcGhQKkm
         eLV5sgC4b+4saesCP0rVzS/0bCTOQNuDEZUSJNu3YoKsFte52+l1QlKOGAiKDWm32QH8
         7V2fKEK5z0fcls9tWgNDwzKcbazm2N0wq+0A/ktrWTGKJ1/7jjViEc8BLu+IAamZS7LI
         A5PA==
X-Gm-Message-State: APuU4Z8nFrGA2G8nZ5xj5MieeVOUwHJX2oIlRnWORb55JGagctLqXuad
	AzM4MKlpBpjn7ulGb8WLikI6RgrMsGYrvdQNqlQW4cRiK9yTDS20WJpA70zceJFU
X-Gm-Gg: AYBFou2IgS+J4mqltvstJFWS9eOJmyaThppBMtiY0AzStdN4ca+Fg+aOBJV89te5kTs
	SXdee+m6zahrRaoLxUeVggBCkjJ08gkIK/4Ua8bDAXL063yvrZoyUMN554p74J1oMCntHS7s6cj
	sBCtZOSZhZALjis1O0FefCmH0X2jxalyIbh1pinQhoH8meeWG5pLHA4wSB6E0+hHTzGGkuv0fMF
	mRHOAPwSFqfEAiT5e80T85GmPay3pLOBbEzKvuYVE/oKDCeZ5zT+VdVxZhKeDnzIb8YLx2TTobG
	qhNaPQ4xg3hrspyXyTyFe5U7Rig1okvoWQqmd1TOGpouSruYXEQxlA+nLkXoM0cMxyVU7WNxYkT
	Wfqmj64ugneCyO7AH2Epzbs7BYPuWERyb8ni41y8k50iBwdtdzY9hgtUpEcfXlqiRdpPKKHA4NZ
	VpJrEEiQjL/NQUbYCo8ban3TfKrYLIWcQkCN96olQBnVgXDvMcR7gKwg+aNbXqPMSRi2p9BJczc
	Ra77J6rcC9CxANXyhOtxXqrwI43ju3cboY5TdKVu8L5rW+K6tXKWqRvUcbawZ8ACzYsJ3KtO06j
	aFFjgJGvaS/o58TwefRvJLgjhx3kTxHLYieEMhe+VRZFADG6LmM0psd50MB4ZA==
X-Received: by 2002:a17:90a:c88f:b0:3b0:e388:d9c9 with SMTP id 98e67ed59e1d1-3b1b0b5d690mr4298989a91.12.1794702919272;
        Sat, 14 Nov 2026 16:35:19 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b39fb9a3sm5464089a91.3.2026.11.14.16.35.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 16:35:18 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 0/6] Get the RRS update scripts working again
Date: Sat, 14 Nov 2026 16:35:00 -0800
Message-ID: <20261115003506.53654-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 00:35:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5378
Content-Type: text/plain; charset="utf-8"

The RRS data on layers.openembedded.org has not been updated for a long
time: in a copy of its database the latest upstream history is
2024-12-28 and the latest recipe upgrade 2025-06-16, so every milestone
since 5.3 M1 shows 0%. These fix the problems that stopped each RRS
script, found by running them on a test instance loaded with that
database copy (layers.moto-timo.net).

1: Bug 16499: every RRS script crashed at startup in the Docker image,
   where TOOLS_LOG_DIR is empty.
2: Bug 16501: load_recipes() imported bb.fetch before init_parser() had
   checked out the right BitBake revision.
3: Bug 16500: upgrade history hung for ever on the OE-Core commit that
   changed the addfragments syntax (8dca5305); use a BitBake from before
   that change for older commits.
4: Bug 16502: upstream history and distros parsed each layer at
   whatever branch the layer index update had left it on (e.g.
   meta-openembedded at dunfell), so most of its recipes failed to
   parse.
5: Bug 16504: upgrade history hung on OE-Core 3c00ad5d3b, the one
   commit where OEEquivHash is the default but BB_HASHSERVE is not set.
   Parsing doesn't need hash equivalence, so use OEBasicHash.
6: Bug 16506: rrs_distros.py failed on the second layer branch, because
   OE-Core's distro_check leaves the build's PATH in the environment.

With these on the test instance, upgrade history has caught up on
OE-Core and meta-intel, upstream history has run for all eight layer
branches (0 recipes that couldn't be parsed, against 2051 before), and
rrs_distros.py has completed for all eight. The test suite passes in
the Docker image.

rrs_distros.py also needs the OE-Core distro_check fixes for bug 16503,
sent separately to openembedded-core:
https://lore.kernel.org/all/20261114200810.31078-1-tim.orling@konsulko.com/

Tim Orling (6):
  rrs/tools/common.py: don't write a log file without TOOLS_LOG_DIR
  rrs/tools/common.py: import BitBake after checking out its revision
  rrs_upgrade_history: use the right BitBake around the 2025 fragments
    change
  rrs/tools/common.py: check out the layer branch before parsing it
  conf/local.conf: use OEBasicHash for parsing
  rrs_distros: keep the environment when fetching distro package lists

 conf/local.conf                   |  4 ++
 docker/settings.py                |  2 +-
 rrs/tools/common.py               | 49 ++++++++++++++++---
 rrs/tools/rrs_distros.py          |  5 +-
 rrs/tools/rrs_upgrade_history.py  | 32 ++++++++++---
 settings.py                       |  2 +-
 tests/test_rrs_distros_environ.py | 45 +++++++++++++++++
 tests/test_rrs_load_recipes.py    | 80 +++++++++++++++++++++++++++++++
 tests/test_rrs_logger.py          | 38 +++++++++++++++
 tests/test_rrs_upgrade_history.py | 43 +++++++++++++++++
 10 files changed, 282 insertions(+), 18 deletions(-)
 create mode 100644 tests/test_rrs_distros_environ.py
 create mode 100644 tests/test_rrs_load_recipes.py
 create mode 100644 tests/test_rrs_logger.py
 create mode 100644 tests/test_rrs_upgrade_history.py

-- 
2.56.1

