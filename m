Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3356C53217
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 11:50:38 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17520.1784893830398135076
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Jul 2026 04:50:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=WFIeyo9h;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-9034b6b7674so3011916d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Jul 2026 04:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784893829; x=1785498629; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z3IE3zDZBFwtcWlPRf//w7Uq74URkOGfRrz7SATbMb0=;
        b=WFIeyo9hkkjQr/XMjjeY8dSiGpdFkYTZHKs9KIpzUOc4U4fmIEFZBNMlW9LRuxoVnK
         Mzygw5l+xImJN517IW0M0rDpcUOCOITJR17zyN6TsdIx6GCKiv18wx4F5RdzAsw9Ck/J
         jhqtU2/zCxGPCZShM68lUyN6DMxWnzQ4d+/zTINR6ru8WbMUH63UA9NZM74fg4dyKBJ0
         0qwGKBYKXMB1K5IRwLjnycGfDg5LwWtL1AvbhnYUQIXtRK9H5n1YbV+z5UHmOWkEPS6+
         sddYxxPM8vINScu+mc8H27ht8Z8Csd21VMDibz9U6qvlmKCI5GWBGpv5u3aWVajzU6U/
         6mSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784893829; x=1785498629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z3IE3zDZBFwtcWlPRf//w7Uq74URkOGfRrz7SATbMb0=;
        b=gFi2jQs1s0DP6YlFHJW+w5yb6cyzvucUUeJyZhCR/jcMrnHYIjcfqHXf0TjLVz5b9I
         mqffnYrV0WeiC3yjuHnXYIBVZ7ZugJVtUR/1wZORZIym202zzaK9M/7Sy6PfEeEWK0Fc
         lBvSmweKRzyH2ovBZiYjNLpEiGyXwU0YsJIfiV9PJWe192gMP9Sss7Bylo+cmzbBPsu1
         Lk5OTBHVLjY0dMn3O5n8xL62syF+dtmaZEPWhWFMatNM0VDBkU6hHhNS0ybfJmcCUMGI
         6PjYoD5ydDpDIREPbgOPWPchRWNQ6pNwW2ozQHFG58DPdweDJ3EDuET65sDeJm5gqHFG
         xTkQ==
X-Gm-Message-State: AOJu0YzclPkLKMpUrOBujWuNK9dOL46rW1gPAPMXIhEjNNsURvhuieWW
	LPgzH463JhMhBobLoOsDVmcjznJ+AtSivJuy+sBHOdjmwL1CtSS6KfDzeh5U3A==
X-Gm-Gg: AR+sD10dmhwpmNQrMRcPNq5oji/20egDrrF55fSUjAvICxrcJyilkAep2epKHECieq5
	LFMqQBVT/p/mdST37Q/Flb8gGqo+48OJIERwGpaKB5tj48MFQO/e4QCLfeDzuRWcGD+VjLAs5+8
	KP56cGbF4kU2qVmvrTp/rz6jF70AUEoGVJKPzbPJ3Iefp8Vf3ZMy+gmqkYEu6NetrtghmZFGwSG
	GHRvTPjyEUGT9rjRv4Pn8Tswqm+Fy1cn6c9IkJHf6ouxBjEXoWSbaOWHxz1PaccQoluj9h4RoSG
	iAoZf/T6a8gE5t4vdbTVCLyUjwlwKoAKqDlHHm66LEZWnPpTihn3nEfJfjcfNdFJHIGTAPCOAPd
	jxaBuq9SlEuZQsHIBSdY7+FO1ImFAmQYXAfio+O8gJZQva7/BKwdjVv82/9Zch2bkL3YfP/zFNn
	DK0UAm6EzjC/ahnqoC2CAkIkBNWYtHgNZFZOamRK+ifIP+4+vCNRk3y/0=
X-Received: by 2002:a05:6214:4689:b0:907:5a5e:ead1 with SMTP id 6a1803df08f44-907ca6b26aamr77996806d6.61.1784893829129;
        Fri, 24 Jul 2026 04:50:29 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa27cf1sm66582796d6.46.2026.07.24.04.50.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 04:50:28 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v2 0/4] oe/path: three fixes plus unit coverage
Date: Fri, 24 Jul 2026 07:50:16 -0400
Message-ID: <20260724115020.38079-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Jul 2026 11:50:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4532

This series continues the standalone unit-test work, this time over
oe/path.py. It follows the same shape the suite settled on: each
source fix is its own standalone commit, and the green test module
lands last, so the suite passes at every commit.

Three fixes come first, each independent of the others:

  - __realpath's isdir guard assigns a bare `false`, which is not a
    Python name; when os.path.isdir() raises, the handler meant to
    absorb the error raises NameError instead. Use the builtin False.
  - symlink(force=True) cleared the destination through remove(), which
    globs its argument; a destination containing glob metacharacters
    could fail to match itself or match unrelated files. Remove the
    literal destination instead.
  - canonicalize('') and canonicalize(None) returned the current
    working directory, because os.path.realpath('') does; a stray
    separator injected a spurious cwd entry too. Skip empty tokens.

The final commit adds tests/unit/test_oe_path.py, covering oe/path's
own logic (join, is_path_parent, symlink, make_relative_symlink,
canonicalize, which_wild, realpath) and locking in the three fixes.
Backing any fix out turns the matching test red. The suite is green
and ruff-clean, and the series passes oe-core's wic oe-selftest with
no regressions.

These same three fixes and their equivalent selftest coverage have now
landed in OE-core (meta/lib/oe/path.py and oeqa/selftest/liboe.py),
where oe/path.py originates. wic vendors a copy of that module; this
series keeps the vendored copy from diverging by carrying the identical
fixes, with the coverage expressed as wic's own pytest suite.

Trevor Woerner (4):
  oe/path: fix bare `false` NameError in __realpath's isdir guard
  oe/path: don't glob-expand the destination in symlink(force=True)
  oe/path: canonicalize('') should return '' rather than the cwd
  tests/unit/test_oe_path: cover oe/path's own path logic

 src/wic/oe/path.py         |  21 ++-
 tests/unit/test_oe_path.py | 378 +++++++++++++++++++++++++++++++++++++
 2 files changed, 396 insertions(+), 3 deletions(-)
 create mode 100644 tests/unit/test_oe_path.py

-- 
2.50.0.173.g8b6f19ccfc3a


