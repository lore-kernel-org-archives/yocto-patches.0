Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D5FC44515
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 09:36:57 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5314.1784540210411467654
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jul 2026 02:36:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=shzdvAc+;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-90327237340so36145416d6.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 02:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784540209; cv=none;
        d=google.com; s=arc-20260327;
        b=JwqQPmjdeojUgOmyHi4NDrzAeKH45Cib5EQi2CW8k76bz+iKAh+gcFTYn55sgUu+VB
         +jbZMp9mKEYqFzZRiz8dbiTxDvm2YziWwt+NyBTtLzvzATqopomf8HE3NZCFmh5jaFpo
         w5OVuMHy1tDcgH+SOzL7Bq46UK8tDYm7M5ZGl2HSChz+n8SFQYhsHmyS5ZJf87qbjFPW
         +2EXjvF2ZhALfYBclAD9yFOCqJo6DXG6FwZuMYuDwUE0J5+xjRtTE4BrK+qaDLxH9uAk
         Y5PUwilfkySZQ7PWsjymDRSRErkXXdqfhe5sWUJnAgW3CXHd+nJYQlccjHYwg2Ss0dZe
         8BuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nGYcchtWqZRWu5XcVNQm4INty0vhpmvwwW3BWqiuntI=;
        fh=XMsRRhzvPpozGn4/ptT17AIFiO5KPD5digb+h6e3kZ8=;
        b=B9ICVWDLS8jRvhQnRfOlPtzeyy/xceLIrpaJvrlaYdgD0brvCefRs+o3pkhaRbgF7B
         jCz4a9UDWhN27m6vDb6PIvXea3Ktt+u3x0YuqWrWu4X//NZ8Alwjg1yR6Buy75YPir+L
         Yt6UdeuosXT0XhS2TJ8jUHfEfOH/d4dUqFh3fPjJuR6hq3zMcHvxa9OxGBG8lGFXDBPs
         jaQLDprspihi8ssrBxdtkd2sLPUnlW2DchWHKhRNr12F5ax78AaRDpGz6rsXvwldAfaz
         9sbzyDF4/gtYH4KABAySvGZiVVyWs9ACM7MTJzVzGPXoIk/wsXnulTKCsFZWtAM0jjfw
         Jm2A==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784540209; x=1785145009; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nGYcchtWqZRWu5XcVNQm4INty0vhpmvwwW3BWqiuntI=;
        b=shzdvAc+cF9jdyHtOk/sKb/8DWBpqMii1JyB/k5uZF6+ABavNkoQlo/zkXZJ9AqcAN
         iJyMvjxOM6+Zu1kKRCntYM3fXlpG0gUgentX1OsW/78GllNxFzScRpEvHPj/oXdYF8Cr
         OhTrvMBTnxj18KrU4be39B7wAknbnPszJsM1OX4F0DnFql3CBAcn8LRiD0cd51k12aGc
         6OKwhachXkNEO6xc9bszdV06zcyteNnYbnZ8P+FuLzw0HFnkMTftVT2VzKed7RE1O5PY
         iph4HlWpQLk/3Zx6S3A+795eoU6wL8NYAWUL4IHR37hQf9umWNHdQfuriqn5tSDM+Iks
         UwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784540209; x=1785145009;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nGYcchtWqZRWu5XcVNQm4INty0vhpmvwwW3BWqiuntI=;
        b=PyEhL1oDU+yNysbh4FoKV6SV4TgKgEU8zzxP9z4yGqnev2mV1H+FWsnZv+zpnp8++i
         K4WDwXtnaBLnPRtE7Y5HcD2je8k+G63wLahUPx168LuTnUtnCQCD5QPGbWU6+SvkoFyO
         jnEqjoW1bgSoKE6lf2eH2vTxIqchs/6l+p3CqH/m44mC7pnVKXIKJeM5W53kaQmQoDS1
         gQCgiR1KtUuxXr24rHIfOik2So51uV53R63+qJpF+PvUTJWjx9CQbhrkLjDNm+eYGgK2
         kFXvY2EuxNQRie78vJUStQBxI10y8Yjm1A1cxsnp1tn2dct64Xi+oj3hIsU26O6NhCuu
         FFZw==
X-Gm-Message-State: AOJu0Yyu8iAcxuPRFxB26US0WjtESceCixwU3h1t/NFrAc64/A0GcZaQ
	19fJN91H+QGtu+LFn5rm2tLbkt1OtnP2LlMByos2+Nr3jwCwG2A3Ya/pkpOckr+kv8F26UXULiJ
	PGOS07O1+cPgFv4s9zQ0m/jbLBqeu2xs=
X-Gm-Gg: AfdE7clwnCzIBk46KWncoarOSB695r6o7YQcfGGM5T+ye6TJCe3MgGlQP8GqnNFs/Qd
	0v5Pwg8pLu3+1gbH2Cwk69Gv0bauXU4r0dtVBD6CMaHrxtBtb4eARtdlLwWPXiFQUWXRfvQ+AZ5
	qTXgqerOwXW8XQInC8b7U1vHucbNm+AHjLCDItvvuIuVnkzvo7E5V3Y6yaZ9bE1jZkjYWFqqvKO
	uRcvkjV6YgjazaxhF4QUIPkFkgRZg0I7awsgOAgFJZlnSfOxvnr3bZzop6Aw8YAOgh95aOphdOc
	fMgV6liVf56lJhYTZjDkAg0y238JfeU=
X-Received: by 2002:a05:6214:27cd:b0:8cd:d12a:3d with SMTP id
 6a1803df08f44-90768eb553fmr181926296d6.28.1784540209266; Mon, 20 Jul 2026
 02:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260527124827.2486471-1-daniel.turull@ericsson.com> <20260527124827.2486471-2-daniel.turull@ericsson.com>
In-Reply-To: <20260527124827.2486471-2-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 20 Jul 2026 11:36:37 +0200
X-Gm-Features: AUfX_mzeuItZ6HeaBB5AANkLq94kqp2HBEIDzSfVcl0LsFGE21UhcMuMqRaNGBg
Message-ID: <CANNYZj_a0hSXOGqh_KOVhcmdnGJKqHyBd5xT=97rP9LObhJYsQ@mail.gmail.com>
Subject: Re: [AUH] [PATCH v3 2/2] steps: include devtool changelog in upgrade report
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 09:36:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4516

On Wed, 27 May 2026 at 16:34, <daniel.turull@ericsson.com> wrote:
> Copy the changelog file generated by 'devtool upgrade' into the
> package workdir so it is included as an email attachment in the
> upgrade report. This gives maintainers immediate visibility into
> what changed upstream without needing to look it up manually.

This has been now pushed to master, thanks!

I'd like to ask you Daniel to keep an eye on the daily incremental
updates that auh will be sending to oe-core, just in case there is
weirdness, crashes, or possible tweaks that improve the changelog
extraction and presentation. I purposely held off the patches so that
you're available again :)

Alex

