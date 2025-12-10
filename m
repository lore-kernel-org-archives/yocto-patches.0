Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0636D2CE17
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 09:59:11 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12035.1765360747113760268
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Dec 2025 01:59:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=errS7i6R;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88677f91e9dso6656576d6.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Dec 2025 01:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765360746; x=1765965546; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=th8dWDT7uIydXZ8XfRlH10F9Cpbp7ppwIA+8qeF0Vm8=;
        b=errS7i6Rqp2fFqpFyMe6reolmOY9nlBWMrHvo+hpfIkXp3LQWZ0pIrveSt6rijwPes
         iwv7Lz2/pBk8kdU40Xwss+G+oqV4sxacaJ4GMU7QXBHDmhY6ExD97Jw9dK/5zTK1Ibfc
         MCShVb2Jf4w6cGA/ZRm2eQ+pa2J7HJZzaOV3S2jArkmHigXBk+8FWxsQdvcNQ3l2wOtB
         iUfB/msPEaSxvPm3J21ewr4LcmL4HaJ3vdRhbcsy1oHAUq5nZbBy7jqeALnvWQKqjVzG
         /SoxGRsX7bLNN17x2lWkYoSpXp73FipOQLzN1rDsl/9pr04B0XCmi5p80yXacQcGJPX+
         8JWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765360746; x=1765965546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=th8dWDT7uIydXZ8XfRlH10F9Cpbp7ppwIA+8qeF0Vm8=;
        b=aw7yWXbAJkwEQo93FGVJIjK4H1bNRVT0Smb3iwW5/etX2uq2/Yy2D9JV5YeRLY5BPw
         kln45RamgOQHye+Iy0YeYvony4ajYxM+9WfnZCOn1qnhjOh9XFqYt0h0iVR/TYmsP4nW
         Mrjr1Nz0Q7NqkmKWzeSdI55as1B/v7dwqwM/HFSnwuJxY1AFiJP+RWjSeAwan8CqBO9M
         lCLVzaAYLTyOFO9dZKRgSJh28rPimUwKhjd7Jfud9xaHQ4wXpEAu5gimEeUCpDi8ISfA
         CqVAzD10bpnHzW8bxU94p1pSjYdRPpc6aKNOmazWcKKCtWsHveDybi/LlSNATEWgvnRT
         KBwg==
X-Gm-Message-State: AOJu0YxLFUoXC10X+YJP3/fu/juGnqKD6GNinrQ2kjUxivkiV3UgnEQM
	tdgvCqPSesk2qrEvILMiB421NQkAjdAWCqqBwcNDmwUAa0rYmLRLNZ/OpjdV5+iypcUiH+uXMvF
	IfEwEcJn6Jb+JPCXxJO0SZPwrP7DlgJ4=
X-Gm-Gg: AY/fxX4e89XWI38aVWXBk2ivUFkFN75JdPkgjVB8HdVn3PT8v5V5kiqI8y2wph/jyE0
	qy8Qe1IxDStEe4oM//3IZvwtCgYnF6o/mfiLLp94JAL/U8P9kW7s5mxoHvnuLmmHSU5twTlTlEE
	iLsEDCcT6pZY5XT1k5Hh4k3v614aQvY965gfDkf29PGKeJ4R6tLa9sS+kMvKo4J3BF9U78szVUB
	DLz6Krij2xBhHrAbZYVzXgt2j9nJ7Vj+ZA1RP7WHcuHfh3bnZHqjnEfLkf1A9dwGIVLPGkijBw5
	bgAAn1ghFLTQpDz5xjWxYxfkGHlotA==
X-Google-Smtp-Source: AGHT+IEMkmiferXqF14dLoHpAThp7z5LygrCN46fItd0mx2qwJJ3uXUohHUbp0Hvvbjv84mWvjNIN1olN0kFbDKo2To=
X-Received: by 2002:a05:6214:311d:b0:880:4548:a059 with SMTP id
 6a1803df08f44-88863990a8dmr25243686d6.15.1765360746057; Wed, 10 Dec 2025
 01:59:06 -0800 (PST)
MIME-Version: 1.0
References: <20251208223118.374387-2-t.f.g.geelen@gmail.com>
 <CAJo0Az6wHkTjxxMYTnwbdxhq0VSnnXvDwtXuuRcd=5vy2NQ0Rg@mail.gmail.com>
 <CANNYZj9O_3P6oUo5b9KnU=dDKJDy3=xdmnDsXPQL=jBc0T07TA@mail.gmail.com> <CAJo0Az4FAesnZFA5Nx3fsLa_TDwbjRBPnb9s7Hz-TMN+FRHsWg@mail.gmail.com>
In-Reply-To: <CAJo0Az4FAesnZFA5Nx3fsLa_TDwbjRBPnb9s7Hz-TMN+FRHsWg@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 10 Dec 2025 10:58:55 +0100
X-Gm-Features: AQt7F2rNmFUyZWI8BLdjPQXDdqP7zKfiHCmYuKW5VeBEqZ_grdb0Xy0Ennhj9SE
Message-ID: <CANNYZj8ecPfG=j-xdZBk6RTnCOnOC179NY8ofnfqUJWAmc6OhA@mail.gmail.com>
Subject: Re: [auh][PATCH 2/2] testimage: adjust qmp detection for testimage
To: Tom Geelen <t.f.g.geelen@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Dec 2025 09:59:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2762

On Tue, 9 Dec 2025 at 23:06, Tom Geelen <t.f.g.geelen@gmail.com> wrote:
> ERROR: core-image-test-1.0-r0 do_testimage: qemurunner: qmp module
> missing, please ensure it's installed in
> /home/tom/projects/meta-sanctum/build-homeassistant/build/upgrade-helper/20251209222910/recipe-sysroot-native/usr/lib/qemu-python
> (No module named 'qmp')

Thanks, this is the key part that I wanted to see. The path is
obviously wrong, so I went and checked:

1. meta/lib/oeqa/utils/qemurunner.py has this bit of code:

        # use logfile to determine the recipe-sysroot-native path and
        # then add in the site-packages path components and add that
        # to the python sys.path so the qmp module can be found.
        python_path = os.path.dirname(os.path.dirname(self.logfile))
        python_path += "/recipe-sysroot-native/usr/lib/qemu-python"
        sys.path.append(python_path)
        importlib.invalidate_caches()
        try:
            qmp = importlib.import_module("qmp")
        except Exception as e:
            self.logger.error("qemurunner: qmp module missing, please
ensure it's installed in %s (%s)" % (python_path, str(e)))
            return False

2. logfile is passed into the class from TEST_LOG_DIR variable, which
in testimage.bbclass defaults to TEST_LOG_DIR ?=
"${WORKDIR}/testimage"

3. AUH on the other hand sets TEST_LOG_DIR to something else,
specifically it's own working directory.

I'd say in this situation AUH is right, and the code in point 1 is
wrong. It needs to figure out the path to qmp module directly from
WORKDIR, but I don't know yet which of the many parameters to
QemuRunner's constructor and launch() method can be used. Can you look
into it? You can tweak the code to print them all, and see if
something suitable is in there.

> Let me know whenever you are planning on doing an AUH upgrade.. I use
> AUH actually quite heavily for my work in meta-homeassistant as it
> saves me a tremendous amount of time and I would love to help with
> this tool. It has a lot of potential.

My interest is ensuring that the twice-a-month autobuilder job that
upgrades all of oe-core continues to run. So it's basically just
patching things up when they break:
https://git.yoctoproject.org/auto-upgrade-helper/log/

I don't have a 'roadmap' for the tool or any clear idea about how to
rewrite it (vaguely, I think the upgrade/build/test loop should be a
devtool sub-command: this would get rid of the horrible heuristics in
AUH that guess what happened from bitbake and devtool human-readable
output, and AUH's business then would be mostly figuring out what
needs to be upgraded, and then sending the resulting patches). But if
you have ideas for improvements that don't require such a drastic
refactor, that'd be welcome too!

Alex

