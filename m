Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29CBC44507
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 20:52:51 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.985.1783630366149460967
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Jul 2026 13:52:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=tBRyQvvq;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f0d6853360so2886036d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783630365; x=1784235165; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xa8Qce7SArEe7eZcxbA9gw4PZBj+apVTBXd8pMWS9Ag=;
        b=tBRyQvvquA35/WxsNFwxOn2Z6dVBWBeaSExoUlRCuT+/7OIfj0PzdoQ3fKIYb5wTB9
         q13lG0xTYsHtYJAXFHakaZdWHBqj69ElHjhSTeL8o0iykYewwMfCZ94W+CKJH+mIAgJX
         BjjM/Bd0xDTbfHvrWxXU9Mzur4HSMkI4QylOtr3JPvcUXkxHu/WcDoPEfQXAxPphiz5E
         xAGTUnybCamNP4M5c6uk3Nm0ki84fhZGHBNytwZoImad210nFn0YxSVwLmyffKIOp6vy
         bfdY0cawHjLIULws2L5viRw5PMs2UNhVbRuy+UMJPyYfgiixoSG/QyN7oBHTWuFQ+Uvs
         FzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630365; x=1784235165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xa8Qce7SArEe7eZcxbA9gw4PZBj+apVTBXd8pMWS9Ag=;
        b=RZJny+mSM1CNLybzovBf2cE39oe7u5d2Eioi+m+SEbaUCx5w0A8rPmWTaOzQTj+bHy
         lQZ53V+Qv05ShCTz42DxDpE2duQuclZDyIGRgPT3+8kINPpaZ4H5c/2e1v6Wnh25vx8+
         Bw7tDkHvnX0ruL9lnOI8a88Z0jxM/xJlGGTVe0oZnc/uDTp/LPqNQJmHO9+8hP+mhbl1
         6DiT0K+IpvKQ/rVsslfMUK8vpIMr9+ZgdqDVrQaMsQkQM7JdGzvJtEPu2ti7zAj+/it8
         doGJwEoV+2/UiKFe8dHCrn4S1oZ6a7m5ijHJCZFJJ61JPVG9Mk9LgF0acfqwK0MpEIV9
         Qbig==
X-Gm-Message-State: AOJu0Ywh2Sf10uGO1+I1MJVLILfZjlPnGvpymkouquQFamwsmpNsWj3u
	ahtKceN2soTojzy4NDZAVXujh/yIWBEEaUxZi5HCkZt9dwLuqdgkFM3bxoRKPA==
X-Gm-Gg: AfdE7clTr3iuI/Y9P43H5//JgYeXg4UvzTL9KVcsf6ZVp7iSY9YURdCj9BFe46j9E/u
	iSUJdl3Uxxp/M39A80E34/9RaHhqbYPl+PDBcg1/etY3zzGVfjQVHL4WWXLy74sAXnmKqSuLKOX
	ycfulu53vQJzFtHOIdyZV1rIr42hwAAM0Co0nVZbyvqKSlhw448ux1BllHBTvSgvL4MrRWzgWJ4
	KVP78RE4L7lPlOFR7kvqqhNtjrH/zf7NzqGVfof+LZoLB+vs4Yg+47wwfeOIU9CFRILx2TVqyfP
	BNFONNs2Pz14sBdtX9RWrW9D8vEvnXKYmvS5jD6QaMltzso3AGg2zFcTK2IkU1GRzdcBZJ7+K0s
	H9t4vmNjE+Nhl+wrTaz2g6U9c86sWbZ0kFTXNfvc7fZzBgXUtt5LD5z9syT8RJxcGdw5UuRbm3A
	O7KdgOhS6iWH0aU7XcBOBm4emc95AhL+K+TwVLccg0Mnfm5LIEej6EOslf/fHnCiX1Kg==
X-Received: by 2002:a05:620a:1720:b0:922:e670:9e83 with SMTP id af79cd13be357-92ecf5e61d8mr933344185a.42.1783630364723;
        Thu, 09 Jul 2026 13:52:44 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d37540sm32893085a.38.2026.07.09.13.52.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:52:43 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 0/4] oe/path: three fixes plus unit coverage
Date: Thu,  9 Jul 2026 16:52:23 -0400
Message-ID: <20260709205227.3470712-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 20:52:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4459

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

Trevor Woerner (4):
  oe/path: fix bare `false` NameError in __realpath's isdir guard
  oe/path: don't glob-expand the destination in symlink(force=True)
  oe/path: canonicalize('') should return '' rather than the cwd
  tests/unit/test_oe_path: cover oe/path's own path logic

 src/wic/oe/path.py         |  21 ++-
 tests/unit/test_oe_path.py | 298 +++++++++++++++++++++++++++++++++++++
 2 files changed, 316 insertions(+), 3 deletions(-)
 create mode 100644 tests/unit/test_oe_path.py

-- 
2.50.0.173.g8b6f19ccfc3a

