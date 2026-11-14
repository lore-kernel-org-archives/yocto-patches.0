Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3956.1794620324550040919
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 17:38:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=U4T/RUXf;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso838355a91.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 17:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794620324; x=1795225124; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N+vaNcF3hJOjkISekh04eA1WWMkwjIROfjwqs1V/Hqs=;
        b=U4T/RUXfZIwz8Tndx8D1F2fc+zGLQrnDjl6avzzjTCKeC1drqnZZBr5343G4VREuKf
         ADD0QPqvxkOeIwGfTAo5nVLifMWF3jkoxQkQXTulaWlfPCLkVhQ8Y1Xrxsi1syXaMcUY
         2yYvNe22nDF48V5vEd06aGUmVKblpZqj5l91WgQ9Rssl6cXNTzgkghhX9Hc8oV9gdbGi
         uaXzFgvTsGBIwRxJK/ascahONiX2zcS3iRjT0lVq3jj98wZPymqbC8TVC7yMd1e2DeJj
         MQB+iP1aAcXvQTQy91Qg1KLT2VAnwxHB9w1mbPIiDHIna2SYbH77QgMVsjPfJRxXnJlA
         m1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794620324; x=1795225124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N+vaNcF3hJOjkISekh04eA1WWMkwjIROfjwqs1V/Hqs=;
        b=S6TVPVnWgFkWe+4mCHRQQa1oD+VTwy+ddAnAh8mNpU8cyVb7miAEUsGM0j9OP5vzcw
         CP3Tco8O1VeZvuiSXwMLtbXZ/PLgY9hi4tRan7vtXgPzA6KsPKbQimwCsD9rxen6d4G7
         YamRJo8weUOqENcZuZlUPrOZ6Q/VYsA80UmyCZOwgZssVZpYWXnbfLy6vdHybfrPFg15
         Vay5Pq2oyEUmbpF2KbdXCGD2pLQZLOgRO2j+GdE5JO+lZueNkgEX0vOH14M/+B5sDuSD
         Sa9QhQja8Fiig3NVKHz0idcvpfCPFDveLan2O9jqcEROqq+9CM8uSHp+15GqlyXx/j8c
         sA8w==
X-Gm-Message-State: APuU4Z/lTfOLaL8xh1e0Lza+Q86PhGjY2XtbEA8mvrepX3LmFBKfke8+
	CDKgxKZbHixRhO3MSSm56MlxqKP8YCeH6COSkbV2iqrELkrclGA4cyHQUAHh5g==
X-Gm-Gg: AYBFou3+FuBrA8ik5Q6sCvELh/v74y8r4SnwH731WpgKy1W+slkMf/qPzeUYvvcL0jJ
	b6C6u5RntfhsL1P5a9cJKH12gCe8TJX9xZBT7Bj8LWF9VJt7Wwg90Eq0mMbTwuYMVbL2kC06Vh3
	yFDQ2y7k+lI5ejU5yFEZMbmk1SymQtDrddhb3acl7RR598aZbsvaBBnrq8jiL+rwHTqGNnSZK3J
	lIXX6PR90GyCI+5jXooxsLJHA8naq6ZpXyCTawejq0dSrIk/MVnkFFsi5xu9UBXPEz+XBDLYQIa
	MTbsha8/A5llq2rRgIvprnP3xwzYTQMVUWuz6yGWmr8V0cuolRwor+baaU4kQFZ2G3XmmznMmrb
	uFrU3+5/mdsPhiAtrMT8FxHgbRg87vs+2lsJL7jlYWZJXAoVELPIQayGvU8dzFAeatD/LQoHijw
	/ILzwTckcpO5VCj4c9n5BTRjK6pON5VW5xhauhSfKLhvo1K04H8No44p76Q7p1tCOczxf8XOuz7
	NwOgbw5BhW4BXy8yYBjw3w4mJYH/INqRI/ytFcST/DXEkbUqsSX7sOXjfzx0OBNzRhsddskjX0P
	ExGmTGiOTck42B+8jAX+B0U4i89hzcyCQ03j5CpdCpzxHZygDe8OrirE4SPoxw==
X-Received: by 2002:a17:90b:3c45:b0:3a8:cb54:e135 with SMTP id 98e67ed59e1d1-3b1b0a1efd5mr4229427a91.19.1794620323819;
        Fri, 13 Nov 2026 17:38:43 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb18b73sm6593679a91.3.2026.11.13.17.38.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 17:38:41 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 0/2] Remove dependencies dropped from conf/layer.conf
Date: Fri, 13 Nov 2026 17:38:37 -0800
Message-ID: <20261114013839.51312-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 01:38:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5353
Content-Type: text/plain; charset="utf-8"

1: Fixes bug 14348: when a layer drops a dependency from LAYERDEPENDS
   or LAYERRECOMMENDS, the update only warned about it. The existing
   REMOVE_LAYER_DEPENDENCIES setting would remove it, but also removes
   the dependencies added by hand in the edit form, since nothing
   recorded where a dependency came from. This records which
   dependencies came from conf/layer.conf (new field, migration 0056)
   and removes those when they are no longer there. Dependencies added
   by hand, and all existing ones until the next update finds them in
   conf/layer.conf, are kept and warned about as before.
2: A typo in an error message that raised AttributeError instead.

Tested on a test instance loaded with a copy of the layers.openembedded.org
database: the migration applied, and updating meta-security (whose
conf/layer.conf now lists only core and openembedded-layer) marked
those two as coming from conf/layer.conf, kept the older meta-perl
and meta-python with a warning, and removed meta-perl once it was
marked as having come from conf/layer.conf. The test suite passes in
the Docker image (80 passed, 1 skipped).

Dependencies that are already stale are not removed automatically;
they are still only warned about.

Tim Orling (2):
  layerindex: remove dependencies that are dropped from conf/layer.conf
  layerindex/utils.py: fix the error message for a bad dependency
    version

 .../0056_layerdependency_from_layer_conf.py   |  16 +++
 layerindex/models.py                          |   3 +
 layerindex/utils.py                           |  52 +++++----
 tests/test_add_dependency.py                  | 104 ++++++++++++++++++
 4 files changed, 153 insertions(+), 22 deletions(-)
 create mode 100644 layerindex/migrations/0056_layerdependency_from_layer_conf.py
 create mode 100644 tests/test_add_dependency.py


base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
-- 
2.56.0

