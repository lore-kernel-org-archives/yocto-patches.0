Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1FBC79FAD
	for <webhook@archiver.kernel.org>; Wed,  9 Sep 2026 08:41:16 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7206.1788943270992823041
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Sep 2026 01:41:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=IJH6pjOH;
 spf=pass (domain: gmail.com, ip: 209.85.160.174, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5218927884fso78698021cf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Sep 2026 01:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788943270; cv=none;
        d=google.com; s=arc-20260327;
        b=phbRsQzEMQ0IjhGGgIAD4xtu23v3YCIkff8lfIGmx88KmZDYNwiooGIf/HiX5xOFZM
         KWXe9jQkmkFQzUjIPUNRn5iqrv5uz17L1Ggo/gWHwu7JE+wYvwG6SL989V2DJjHePdoB
         LBM8OtRFGMAaKWCcbVMW0/4wyCjikusj4QdJm7YMGjXqOxYOd4aZqCbpE0wxNAMVBf7D
         Yook2cB9DQoNF/MDCn7jx6FXkOkU66Vg6WRsGgY4wD/BxlEoTPuk7FMXYoA4wis1hyaT
         KB+nyAD14U4vvhNZlkKJ8DRzSX+kSWuVHA1JdwRMHUTVSebBorfiup/fYjvLUK8SOWJx
         mgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RWq+6sM7U9zI1MRJeTmBTRhM+cOMbuGdx34618ZRuUw=;
        fh=28JQhdK5h5mLF5DLv2fLR8YFHEF0yTvH5opUNnJ6Zzo=;
        b=nS3liW+/EJIHHP/+/n9qKFTcSMUOHhZQBzXpD6qGbatxNal50sh5vbr1TLDv3yhNgQ
         SfKy64gEyN+Jrf6qWvP0UKcRx8dp3Z+dZA286ATgEnh06CjWKPmncAAk1Jxb7txuI5p6
         gfwbGYa9YxI3yfHMJqt0U7sr1Fo6ylIvYkurMEeXWJv+n3zVwfMGykN4qv8OZQTfXQil
         cikxdNEPbTDRO/kZ2cq0xC0VWBUxkz7AOUu2Najge9I1Hz9FQBO+ye91beKfd1MQ5uWx
         bgUdlRbeBd0gExTXR7xiUgTAABkNAIZX8qCsZhJcZXtRhCBIWWOMCiHrl1pkUOVsuxSs
         vWcw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788943270; x=1789548070; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RWq+6sM7U9zI1MRJeTmBTRhM+cOMbuGdx34618ZRuUw=;
        b=IJH6pjOHHK9o4iZeHl5w12X5vu/q+Q/+RYuW/lcUG7CDr6fq4LblNf3NYwxOZUneqi
         t2+lgipb6Pj6xNAK+pJgnZ4RgKOgszPv3uoxN5NzaC5tqXq+eIDApYFXQWQGjosUomh1
         L2aHxgAUtzuWCgCyyAPxw7Ag1/3mfR/Qug/MaCp2DBzHg+P+/7wR5SvZIN6sfGVl62Sk
         /99ExzwSGpRESDBfZGK4PFk9wkeHXYr/+SZcXV16ypMc+ZT2Dstru6VAgI0Y/hiHuYTs
         Y7/9aIgrRbs/VPx50c7ma2BvtJgKUgEzXSP7UU3YGlDJVtZFYG/Fx1eHpAq5zop5Jm0o
         AH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788943270; x=1789548070;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RWq+6sM7U9zI1MRJeTmBTRhM+cOMbuGdx34618ZRuUw=;
        b=h/RNtcm+00qVcRd5+NbqpAJcKqPzCf8DA+K11GjxUNQ8Qy8lKa3Mq10qeGipBP+sjz
         fy16aEYclkavIfWlGGwhdPxIFhcehwZ7DqXxbHX78ATmZNDP1IwDqlIi03CU30INxo7z
         1CQTZCvK9irH0Zkz7RQthZxNYf+vsH9LwzQgPWScSp6sGv6hUhk22uH1QmTg55Gn5K0z
         uGs1HB/g/YKWDAenxMTgfrMtm4Bqyc5OK3QHgY1YrFqoqTvdKlIYoQR2uBKSYq+auiXh
         RTE0ay8DotWbYCM710mXFy3b+CuDqyOfhZvQrKqpdz+Y2gc3KQLbaL6JpmH7ytukQK3p
         hL+Q==
X-Gm-Message-State: AFuF++lP6O36KkJPQQGaHdqHE3IvvFwFmCFnj/VXdvf1fNz2kzBUzDTP
	iip5pIi7KYH/LAKT89GBfqSOb9vX/d04UgGbeosks9qXS2mwtCi2+KgbM0z+Q/UctpJIcu4Wb87
	jUC/Xreo5nk9r0yFm1nOFs5ddxjIW7iM=
X-Gm-Gg: AYBFou2zal/rCwvaWuEX2QUrVDi+Dos4C0fPqrM+Z7Msr8IelRkY/gMcIlvLXpWqMk/
	od0r/JRcKxeGiVmgg1vMIUBLKHyaswpmEYGY+u/RpN+t1rMIj4jfLfWRgZA8oV//p7HhTCPDUPP
	k09ifEvrS9QogrBGIVCl3C0sUhx7uTSy1X0caCMkL0eM+KlQF6X9fqBN8zetN8Aluljt6RpHWmQ
	0y4zDJx3alDTUZvuu6uswOkiwFANc9BpKeUbQ0h5GoM4dyZhwk0GSuOTHwEd/mOfg7r+7qDMeNd
	4NTRO91d/BWaQJCMJHwOMSgTUnGoc+dYZrcQX7Vr09MaGybfmRSx7yZPZYTMpKW+6Ij9rmpystZ
	ZVA6dMQ+mQzJk17P8gQH74mRP
X-Received: by 2002:a05:622b:8f:20b0:530:8a37:ad1d with SMTP id
 d75a77b69052e-5308a37b343mr40747251cf.45.1788943269690; Wed, 09 Sep 2026
 01:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260907131252.2810926-1-daniel.turull@ericsson.com>
In-Reply-To: <20260907131252.2810926-1-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 9 Sep 2026 10:41:00 +0200
X-Gm-Features: AcwNN1VOWfTeuarUoL5uxcy0O8cfbyhtIdsXShFWKDIoxVZ_pD0KYMpRRcWmhDU
Message-ID: <CANNYZj-TeqYEDbrR6XLPv119e38QaPGDoA7RDTDczTnA38d2XA@mail.gmail.com>
Subject: Re: [auh][PATCH] steps: ignore source in commit msg
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Sep 2026 08:41:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4755

On Mon, 7 Sept 2026 at 15:14, <daniel.turull@ericsson.com> wrote:
> @@ -103,6 +103,8 @@ def _append_changelog_to_commit_msg(group, opts):
>          text = p['changelog_text'].strip()
>          if text.startswith('Changelog for '):
>              text = text[text.index('\n') + 1:].strip()
> +        if text.startswith('Source: ') and not text.startswith('Source: http'):
> +            text = text[text.index('\n') + 1:].strip()
>          if len(text) > max_len:
>              text = (text[:max_len] + "\n\n[Changelog truncated as it exceeds {} characters; \n"
>                      "the full changelog can be found in an attachment to the AUH email]".format(max_len))

This code block relies on brittle particularities of how devtool
writes out the changelog file. I wonder if we can rather make it more
structured, e.g. devtool writes out a json with all the metadata
including the pointer (filename) where the actual changelog text is,
and then auh can pick and format pieces the way it wants?

Alex

