Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0980C982D8
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 00:46:02 +0000 (UTC)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39801.1789951550501034264
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 20 Sep 2026 17:45:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=iL1F3O2b;
 spf=pass (domain: konsulko.com, ip: 74.125.227.140, mailfrom: tim.orling@konsulko.com)
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca069c8so24284625ad.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 20 Sep 2026 17:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789951550; x=1790556350; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7jxz3Q9S3nd2XTknXZyZZKNEF4mSuB54KADQad6lMVY=;
        b=iL1F3O2bS9XBytzB4brRzgZjALR7zpyOO9l28x869gVmcYK6SBqwR5HzFRimT0lw7P
         nH0ZNeNwAq6npeDvJnXXacAdPrgK6ucVTHJG8sxN1BGtOchy6YeFbXuO04h7hISTK5MO
         rhhhJlth40WS+GLOW4N/e+ICaLlln5vU8WeVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951550; x=1790556350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7jxz3Q9S3nd2XTknXZyZZKNEF4mSuB54KADQad6lMVY=;
        b=JTSwFna7yUZQc3h2A5AjqNBffYUrdTLh7HP/3/qd5dcAu0sSUQUtbqLLDLDvkMnU6Z
         i8zL75NpPGgqFpM2xaLQmVYR1KSlG5zPqgEUQddXzgSOh3uzmA36YQlfarvfJ8+t7pJ2
         25IJIXR7gQYuxjInYu3X+yj3EHhZ50pOcBlwOke1CNBADvPprzlUXx/Gzaay+IYkLh3d
         eE8bkwgjrmBlPK3U9Q3QRA9z6cB6Um5Bj5mNvH7q6WfczKLPpX2tU3Hww+Ur6OLBmr7v
         lk60gXKTUP10PB8Dktug2QsderHbujm229Iv+NHTc8cnMGKY6xgfi/ygsJZMXYUKcez/
         Dbew==
X-Gm-Message-State: AFuF++mZHgBZ6VPzRdwElIXbaouFnMrmDJYtuj+2R+mmb0tv07SzwB5V
	YnzMOJtWXYlOMw+QWrCy10BPgSVThdy7ZTS7TngNYoExT+tIQ/4Fz+VfIzInaHaI45/0qGEqsHV
	6Bq13
X-Gm-Gg: AYBFou093cOi/Q757LQrodTrlscZHvjvg/wIUABE6qqQ7eLxV8c/jRICtcdHzWxRFiq
	GCR3kosiweOcBn96+GfqZ4bzk/O1FZezn2oQbC4fAlmmB9ZSmIxpuQe5OeST7DJRHJpKjor5Jl6
	dsi9KEfvww4/vPmIYOuxNmusVZWnRRxObEFkmk7J3X0Gizmd192vh+E2lkstAUrPw0nlx3/TFjy
	g1l1UAcVqCcRDuJAbASB/qtM5z9/oRn0i/u3Oqhx50lHE1r7smO5okXxNPM4xo5tpivEI/LqyF2
	zTkNuFEHOeo3khyE1uVmU0ZFAil/KsEOYuXrTvubXVn00Ks9UOXXnlGsXWhRzb56mFM3zR96Kfs
	m2+YdJRfZaSBkrBLjIcdNVLtIKubTop9BhLJ7VuEEOTQQRamhxtPAD6Af3LelsQXocBO0A76u+A
	85L/9qb4PSQ1vl2Fw9RiGxyAjDmckFZ34+z9mIUKuXOCglHo4QUWEKPnUZ07jNos5lbbnBpWvWo
	7BsC/74re0h6g==
X-Received: by 2002:a17:903:94c:b0:2db:2427:97d5 with SMTP id d9443c01a7336-2ddb1ab3c03mr146268825ad.4.1789951549734;
        Sun, 20 Sep 2026 17:45:49 -0700 (PDT)
Received: from thetis.home.local ([2606:c800:6024:2000:7821:4c5:938a:e12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc1803813sm24512385ad.82.2026.09.20.17.45.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 17:45:48 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 0/4] container improvements
Date: Sun, 20 Sep 2026 17:41:14 -0700
Message-ID: <20260921004540.3718904-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 00:46:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4913

A recent change in 'cosign' now requires agreeing to a prompt, or
setting COSIGN_YES for CI builds.

We were previously declaring --type spdxjson for cosign, which is
an SPDX 2.x declaration. Use the more explicit SPDX 3.0 declaration
instead.

Add some improvements to the time taken for the "push-containers" step
in the container-library job. It shaves a few minutes off of each
container run.


