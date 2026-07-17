Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2759C44515
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 18:35:19 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3145.1784313314108030297
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Jul 2026 11:35:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=j3/sYLmF;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f256eaedf8so89741256d6.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313313; x=1784918113; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vBQ367w8xodLYDMz9UOv2IY1/WIHCs/SwfdEszIHyfw=;
        b=j3/sYLmFmgwAmxcAAUYildC7O5M7pRKzk3huUlgHHfGZK3C9SQgkGNMNH2120yMooI
         TcDZ3m4G5sMh9ouu0s6QPqnKA/lhDyKITub+FNX1EBgBO2MBVUhhtJYTt9RRiE4kz6np
         4mKKBIcefQSgeyu7d/s6AVD80sFHF27FNidTw6V+gPB/aKVYSbIuAghTXX1JpELsphUi
         8s22ZQ0z4jDxXquNvgn08zdkaNTkqk++xxej7/m2cOKQ2d1xCPEKkzD8t6ggK1Lay1gY
         wyy288CFo9Fwk60NkntNtvEbDSmUSOgNlpHtTuqyRHlkugDimYugPxJ2EJ7F9S8YRZry
         5F9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313313; x=1784918113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vBQ367w8xodLYDMz9UOv2IY1/WIHCs/SwfdEszIHyfw=;
        b=FUG/rW1r0Yf9LSM4/tjSU6DW44ePzlOlyttwpYoQ/7PL+yIrBPT9B9e1ln2IUo+PtD
         w7cZCcM+YoXYOfPOgTNqRhelmh+v1y3ZcQ0G8l5+vTmT0tafV++FT7g7ave+YZ1Hym9g
         kcYnj7mcQFwUE4EMDG6GyV8F2wlhFp5rKmxk6rtnegAfIsCEiquy0dmZsAQUxa/8dq56
         3XjTexJSKuhA+kHWIZGZn+57oteK/xLtxZQg2SOZyzgESSC2Wxs3PCPZkVIwHIfoeWjU
         jMkIJG2WjFvJzahsyBFXYQq/jhbM2B84vB7OHY3p92AUbmD93zw/R5D6jRCXrXHgIemz
         iIbA==
X-Gm-Message-State: AOJu0Ywfb0BPgS03uECX2MrRomvFGt09xOy0pmhzVRjXmc6kYU1Os6NK
	htjRCghc3lVIQuy5XwtoEpogDQsNfZ3SwXZMM1+ER0aEEXxgXZThQl7JyP+aBg==
X-Gm-Gg: AfdE7ckKsjdc+VrSkYM2E0iCHu6V8tko/BXrSfTuTPft32YEMqhJOI0bUXq1CbzOXoP
	0uUOTwFC89JGVvxQ5qfElSzrqVK2BZrpWHAkKbO7Cbgw+kig3vfqIcrOVvOVZ40f3Ov6qJ+DbgV
	r8Ndjl4zE/FJodUlwhzSaH8HX/HKBjjw7D1z12WeBeVApz5/duRRw/VUCRljzGbUzcEDW0XXzrv
	WSLQj56uU1FNaJNLbA9BCUZcHdUUa5W/1mRJgRoyJ+tFVk/io7vVZKUvhrpRByNQXjKSdFwTM+z
	JJdpIaalnBqgj+vmpuMiv2hpK9nCNAxFsX4GzWlvgbwvJqEyX7SdQhnjQHLjkH+WM9D8GAqIC37
	LD+ps3J6wj8ZwVGB/ayhU6D7inU+IEpmRYQlSzmW+fDtpz+NMcadkCcJIwzz95Fvzt2U3dOopm+
	86nb7QICPGVrehAZVML3/xtDsLbmet/egIoE96yC9PIhzAEb0QiO6Ppbw=
X-Received: by 2002:a05:6214:4283:b0:8ef:5c5c:dbfc with SMTP id 6a1803df08f44-907783c22femr42712696d6.43.1784313312912;
        Fri, 17 Jul 2026 11:35:12 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b21d6sm22992816d6.24.2026.07.17.11.35.11
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:35:12 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 0/2] tests/unit/test_ksparser_parse: parse the .wks file, fix a diskid crash
Date: Fri, 17 Jul 2026 14:35:05 -0400
Message-ID: <20260717183507.3539287-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 18:35:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4504

This continues the standalone unit-test work, moving up from ksparser's
argparse types to the KickStart parser that drives a whole .wks file.
It keeps the shape the suite settled on: the source fix is its own
standalone commit, and the green test module lands last, so the suite
passes at every commit.

The fix: a bootloader line with --ptable msdos and a non-integer
--diskid builds its error message with "... % self.ptable". self is the
KickStart instance, which has no ptable attribute, so the interpolation
raises AttributeError before the intended KickStartError. The user gets
an opaque traceback instead of a described error. Interpolate the
offending value instead (matching the gpt branch just below), and fix
the "--ptbale" typo in the same message.

The test module adds end-to-end coverage for KickStart(): happy-path
part/bootloader lines, degenerate files (empty, comment-only, CRLF,
unknown directive), mutually-exclusive and invalid option combinations,
multiple-bootloader rejection, diskid parsing for both ptables, and
include handling. get_bitbake_var() is neutralised so the parser runs
with no BitBake and no host tools. Backing the fix out turns the two
msdos --diskid cases red.

Trevor Woerner (2):
  ksparser: fix crash on an invalid msdos --diskid
  tests/unit/test_ksparser_parse: cover the .wks KickStart parser

 src/wic/ksparser.py               |   4 +-
 tests/unit/test_ksparser_parse.py | 217 ++++++++++++++++++++++++++++++
 2 files changed, 219 insertions(+), 2 deletions(-)
 create mode 100644 tests/unit/test_ksparser_parse.py

-- 
2.50.0.173.g8b6f19ccfc3a

