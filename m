Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829A0C44520
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 16:33:13 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1658.1784565185671095440
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jul 2026 09:33:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=d+j/NLkc;
 spf=pass (domain: gmail.com, ip: 209.85.222.181, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92f03daaa97so806766485a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784565184; x=1785169984; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PB8mLDsXt2SiiS4ErJzcU4Z2iJpWTlcscytmua04BjI=;
        b=d+j/NLkc4BkCC0IiyC6zM/CKbp3zg8FuKBQpJhKBgMYgKhfWC7uj2fJlAdHh2cXjvu
         5cjtqdSSRxa9NYYj/ZpvEXZqDiz+ZG1UxZvhHNXFsmHfrVTlMRNnI3oyaqXY1QzXPocR
         UhgCM7JJWFwlXzQ4oTavxjLJb7zRLByyVBaIqWWCNWpyTZ5IMW2vcK9/ULibv3otoOZz
         mXWeeogO2urjaudtd13N8WRWx3Uc/QdAHnSXUqa6hWImKamH509Cb77h/5k1nGWe2Qma
         NvDlzVDPVQakK7gK3LPK0U8+VEsfG48HP4EcRa4NU6MnAk1zMHbM/88p4eJM7Rf3L/ku
         V7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784565185; x=1785169985;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PB8mLDsXt2SiiS4ErJzcU4Z2iJpWTlcscytmua04BjI=;
        b=efcWb8FU5i3CMsztazVOuaYcCViqMiVxSjhKzGLXg/0UvZAfEucR5K6+I8sfOLIogr
         5/O5GLyHalgNsvwXt2bhvtio6xH0LcM6c2gtNsQeAZ3ZN/KxgNf2K+WMIFHCNhGloKVs
         MRNryniXRA2eIM8I6CbBR6L3VheeM/fcFFyxRFiIDhc3poJ9Y9bcqPOisxjG6tWVWEaf
         5Xl8IK3NRHvCjQkKrj37CvOmSNREo867UvOSJljRvEFySW9CLewukStLsAQi7hcnbLOI
         YKYb5eKISo1HYdc8sc5fas54+2oLmFSR5QaA9ZcuKhHGdn31H9Wsei48k4f5Vl0oG4ze
         YXTA==
X-Gm-Message-State: AOJu0YzEz0bAh2eb3xe3WS3mdZ4ynVfUV6Q8KDmsn7jaa+v1yVQBsC0O
	SzKbXcudASzWlMjY/hzLHgmohEh2wvO37jBQj+6v3EY2RKbBvzRxB6TE6bHX2A==
X-Gm-Gg: AfdE7cny4NpqgoYtX8z8OkLSP9G5Dqo5xZ3hSfKKTqna8yhjOk6q8f9w3emEvxo+3Wp
	tq6nnYPludr38Mqf0AIbaM7+OBu2iIyZrx6y59j/Ey15DYIIUSGxQXtCbEQ3gVJfykHM9sYv6iV
	MRJKuiqzMK84Gy18RjNDhuenuZBqAfHAWcgRfC/bQtSBJGsplSSeTM27Ge/uK48qQYlpcRyLEJp
	iuMgA6muOUiBieCv7lozrLhu14XmPoeoxwUZfgZbCxoC+38lCKdsGKkXESYq/+TjcP3781xmTV0
	H3Jmhjifoae8AZ0ckVSFTPXdOH9h4WYkOCTjRRkLeB763lFVNw5N05VyMQH+mYw0HsBy0ZBeKEG
	OlyKeTSjZiCe2+kMMFV6gWH5HBurbw/aiyuLpHsfM4SWzsokNe+J0Ys2GXg408tjekn1N+6MXPA
	TrTh67TCYtKeQE+f7vwEgxp+erS5aE2OyYYgougPsMhgmNCxuff8/gL/g=
X-Received: by 2002:a05:620a:29ce:b0:92e:4b7b:b509 with SMTP id af79cd13be357-930b431515dmr1411070585a.70.1784565184169;
        Mon, 20 Jul 2026 09:33:04 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b542e60asm932301885a.31.2026.07.20.09.33.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:33:03 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:33:01 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [wic][PATCH 0/2] tests/unit/test_ksparser_parse:
 parse the .wks file, fix a diskid crash
Message-ID: <al5NvS_nPhLaYxNJ@localhost.localdomain>
References: <20260717183507.3539287-1-twoerner@gmail.com>
 <f521a495ed0c8fda8918d0a4cd2be4fd5829f8ac.camel@pbarker.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f521a495ed0c8fda8918d0a4cd2be4fd5829f8ac.camel@pbarker.dev>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 16:33:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4523

On Mon 2026-07-20 @ 09:27:22 AM, Paul Barker via lists.yoctoproject.org wrote:
> On Fri, 2026-07-17 at 14:35 -0400, Trevor Woerner via
> lists.yoctoproject.org wrote:
> > This continues the standalone unit-test work, moving up from ksparser's
> > argparse types to the KickStart parser that drives a whole .wks file.
> > It keeps the shape the suite settled on: the source fix is its own
> > standalone commit, and the green test module lands last, so the suite
> > passes at every commit.
> > 
> > The fix: a bootloader line with --ptable msdos and a non-integer
> > --diskid builds its error message with "... % self.ptable". self is the
> > KickStart instance, which has no ptable attribute, so the interpolation
> > raises AttributeError before the intended KickStartError. The user gets
> > an opaque traceback instead of a described error. Interpolate the
> > offending value instead (matching the gpt branch just below), and fix
> > the "--ptbale" typo in the same message.
> > 
> > The test module adds end-to-end coverage for KickStart(): happy-path
> > part/bootloader lines, degenerate files (empty, comment-only, CRLF,
> > unknown directive), mutually-exclusive and invalid option combinations,
> > multiple-bootloader rejection, diskid parsing for both ptables, and
> > include handling. get_bitbake_var() is neutralised so the parser runs
> > with no BitBake and no host tools. Backing the fix out turns the two
> > msdos --diskid cases red.
> 
> Both patches LGTM.
> 
> Reviewed-by: Paul Barker <paul@pbarker.dev>

Thanks Paul!
Applied to wic, master branch.

> Best regards,
> 
> -- 
> Paul Barker
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4515): https://lists.yoctoproject.org/g/yocto-patches/message/4515
> Mute This Topic: https://lists.yoctoproject.org/mt/120320310/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 



