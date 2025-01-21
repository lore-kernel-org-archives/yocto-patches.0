Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D6DC0218B
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 23:04:56 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web11.29883.1737500691901753437
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Jan 2025 15:04:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aEIl35Vv;
 spf=pass (domain: gmail.com, ip: 209.85.208.176, mailfrom: ticotimo@gmail.com)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30227ccf803so52000201fa.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Jan 2025 15:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737500690; x=1738105490; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=idp2ccfv6vzfDb52aDcKOyQkMEKA557TdIJWjaVzR94=;
        b=aEIl35VvGE0Tw6hslce6SuQ2YPYInmd/JDx720ZebGeo7l6Q0RCeQhkvP9uOoL/ops
         fB6YKfUWMb7YZPmQJMbX59W7Le+4oDgxqK7fECQf/oVvK72JYZVHuD/P1uaKbYCXKY1T
         08ERf78VHH9tCi0lnvHQ9+7bGGw96NX/ftEeSYsMrH3vWhfbFcJFsHq4fEfyDyTW7M6t
         rq+9NAxgddsyc4JxIg7TeZPbIg06/sjpxRTsS9NpSPYxF9o15+EHHw9QMYq+4JopYiy1
         QT2Mrez/UmvfSLIXZxgkslf3xIslOBO/jG+3nMi6jJBiQV1oA/lsgVdIKqbPhCwLcgtQ
         tNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737500690; x=1738105490;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idp2ccfv6vzfDb52aDcKOyQkMEKA557TdIJWjaVzR94=;
        b=Wc6aOlzDoLzgZPbW5J8NWxc7loa5VcNGw2PtJk4Zg+s74jBxRBgxTn7S3nM465xLVg
         sZOVtSwUQ5ApwKUu2vfwlTEiDp13fexSkQBqOqgf6tq6U2z0Xtp0dmWWvQCIPHI/rB7A
         XOdu6mDjiahO+n9waXSOYDVzfsWSQLjXajj6ReWDzQUvwwta8OWRUWBG9hQpXwEI8uX5
         MGDlL/e6bVx1CzaG3lLdJQhvg2s4MpTtr87zgS1nibYJ7xdG89cVuF4rKXpn0rouPlzf
         Xa8U7hFOJq+RioO4xDKWP9SFzUUHVo754nTinvVP0m2De45j0OkwGsQngYnIHWAxeMfa
         14hA==
X-Forwarded-Encrypted: i=1; AJvYcCXr9K6tJDncSnXJ+aujkFbq37SMstAo7G/GTlVhG6gEL75ouw6gM9mknvucYHyQqwabvtPDeIHWlU9YQaSW@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxQa3UDknAeXD2s2z2yrYXfXu4Yltm3vsUFfhRoeZ7lDwyzPTVI
	OA+oI38oe83tgsvLShd1UzyO2R018koMhTGoK0ooE6shD9+wWVQqar24gnLg06y9gUJWwtF2Rhu
	ZEpWynck1kHiiYsfy/34lxRhyZ+I=
X-Gm-Gg: ASbGncvBXp1bUtHrViOJOfKDUPZXWBp647AaoRClnzwXSzV0elPMjn43MGDwrReY5U0
	pqUU440osK7m9BiJWXbHpzCs2NcRm4ieTUX+471lyIQVYruA3C+A=
X-Google-Smtp-Source: AGHT+IGtl+m1mnahkssKzHYKpyON24RVpmUN7zKr9XDfDATl9KYwvtLOBKMKHQGbNurfxf5JXVOO8f+KL07axuHcT9M=
X-Received: by 2002:a2e:be21:0:b0:302:1d24:8db7 with SMTP id
 38308e7fff4ca-3072ca99e8dmr69950911fa.19.1737500689282; Tue, 21 Jan 2025
 15:04:49 -0800 (PST)
MIME-Version: 1.0
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 21 Jan 2025 15:04:37 -0800
X-Gm-Features: AbW1kvbCNeX968mvfhzU-LeD-pgYmj7xTr7Brg85THIxtQZH_R-8rzHYhz8ecdM
Message-ID: <CANx9H-CcvnJM3_pyMEonojr9A=TrkS11PLZJ5vXvqdQwCv5H2Q@mail.gmail.com>
Subject: [meta-java] Intent to drop openjdk-7/openjre-7 support
To: "openembedded-devel@lists.openembedded.org" <Openembedded-devel@lists.openembedded.org>, 
	yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000061bec7062c3f674b"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Jan 2025 23:04:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1000

--00000000000061bec7062c3f674b
Content-Type: text/plain; charset="UTF-8"

This is a heads up that we will be aggressively dropping openjdk-7 and
openjre-7 support from meta-java in the next few weeks. OpenJDK 8 is still
receiving updates, but 7 is long EOL.

We will likely retroactively drop as far back as kirkstone, because to be
brutally honest, we have been broken since before kirkstone. This is a
policy decision to be made, with feedback accepted from the community, but
as the only person actually maintaining the layer in the last few years, I
reserve the right to make major sweeping changes. Many things are broken on
a modern distro (Debian 12/Ubuntu 22.04+) even in kirkstone, so we need to
fix things that far back.

If you feel otherwise, speak up, contribute patches and approach my
employer for paid support. Otherwise your silence is golden.

--Tim

--00000000000061bec7062c3f674b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This is a heads up that we will be aggressively dropping o=
penjdk-7 and openjre-7 support from meta-java in the next few weeks. OpenJD=
K 8 is still receiving updates, but 7 is long EOL.<br><br>We will likely re=
troactively drop as far back as kirkstone, because to be brutally honest, w=
e have been broken since before kirkstone. This is a policy decision to be =
made, with feedback accepted from the community, but as the only person act=
ually maintaining the layer in the last few years, I reserve the right to m=
ake major sweeping changes. Many things are broken on a modern distro (Debi=
an 12/Ubuntu 22.04+) even in kirkstone, so we need to fix things that far b=
ack.<div><br></div><div>If you feel otherwise, speak up, contribute patches=
 and approach my employer for paid support. Otherwise your silence is golde=
n.</div><div><br></div><div>--Tim</div></div>

--00000000000061bec7062c3f674b--

