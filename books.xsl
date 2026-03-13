<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>XML Book Catalog — Final Year Project</title>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&amp;family=DM+Mono:wght@300;400;500&amp;family=Inter:wght@300;400;500;600&amp;display=swap" rel="stylesheet"/>
    <style>
        :root {
            --bg-primary:    #0d0d0d;
            --bg-secondary:  #141414;
            --bg-card:       #1a1a1a;
            --bg-card-hover: #222222;
            --border:        #2a2a2a;
            --border-glow:   #ff6b0044;
            --orange:        #ff6b00;
            --orange-light:  #ff8c38;
            --orange-dim:    #ff6b0022;
            --orange-mid:    #cc5500;
            --text-primary:  #f0f0f0;
            --text-secondary:#a0a0a0;
            --text-muted:    #555555;
            --green:         #22c55e;
            --yellow:        #eab308;
            --red:           #ef4444;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            background-color: var(--bg-primary);
            color: var(--text-primary);
            font-family: 'Inter', sans-serif;
            font-size: 14px;
            line-height: 1.6;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* ── NOISE TEXTURE OVERLAY ── */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.03'/%3E%3C/svg%3E");
            pointer-events: none;
            z-index: 0;
            opacity: 0.4;
        }

        /* ── HEADER ── */
        header {
            position: relative;
            background: linear-gradient(135deg, #0d0d0d 0%, #1a0a00 50%, #0d0d0d 100%);
            border-bottom: 1px solid var(--border);
            padding: 0 2.5rem;
            overflow: hidden;
        }

        header::after {
            content: '';
            position: absolute;
            bottom: 0; left: 0; right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--orange), transparent);
        }

        .header-inner {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem 0 1.5rem;
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 2rem;
        }

        .header-glow {
            position: absolute;
            top: -60px; left: 50%;
            transform: translateX(-50%);
            width: 600px; height: 200px;
            background: radial-gradient(ellipse, #ff6b0015 0%, transparent 70%);
            pointer-events: none;
        }

        .project-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: var(--orange-dim);
            border: 1px solid var(--orange);
            border-radius: 4px;
            padding: 3px 10px;
            font-family: 'DM Mono', monospace;
            font-size: 10px;
            font-weight: 500;
            color: var(--orange-light);
            letter-spacing: 0.08em;
            text-transform: uppercase;
            margin-bottom: 0.75rem;
        }

        .project-badge::before {
            content: '●';
            font-size: 8px;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.3; }
        }

        h1 {
            font-family: 'Syne', sans-serif;
            font-size: clamp(2rem, 4vw, 3.5rem);
            font-weight: 800;
            line-height: 1.05;
            letter-spacing: -0.02em;
            color: var(--text-primary);
        }

        h1 span {
            color: var(--orange);
        }

        .header-subtitle {
            font-size: 13px;
            color: var(--text-secondary);
            margin-top: 0.5rem;
            font-weight: 300;
            letter-spacing: 0.02em;
        }

        .header-meta {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 0.5rem;
        }

        .tech-stack {
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .tech-tag {
            font-family: 'DM Mono', monospace;
            font-size: 10px;
            padding: 3px 8px;
            border: 1px solid var(--border);
            border-radius: 3px;
            color: var(--text-muted);
            background: var(--bg-card);
        }

        /* ── STATS BAR ── */
        .stats-bar {
            background: var(--bg-secondary);
            border-bottom: 1px solid var(--border);
        }

        .stats-inner {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2.5rem;
            display: flex;
            gap: 0;
            overflow-x: auto;
        }

        .stat-item {
            flex: 1;
            min-width: 140px;
            padding: 1rem 1.5rem;
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .stat-item:last-child { border-right: none; }

        .stat-label {
            font-family: 'DM Mono', monospace;
            font-size: 9px;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--text-muted);
        }

        .stat-value {
            font-family: 'Syne', sans-serif;
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--orange);
            line-height: 1;
        }

        .stat-sub {
            font-size: 10px;
            color: var(--text-muted);
        }

        /* ── MAIN CONTENT ── */
        .main-wrapper {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2.5rem 2.5rem;
        }

        /* ── SECTION HEADER ── */
        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border);
        }

        .section-title {
            font-family: 'Syne', sans-serif;
            font-size: 1.1rem;
            font-weight: 700;
            letter-spacing: 0.05em;
            text-transform: uppercase;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title::before {
            content: '';
            display: block;
            width: 3px;
            height: 16px;
            background: var(--orange);
            border-radius: 2px;
        }

        .section-count {
            font-family: 'DM Mono', monospace;
            font-size: 11px;
            color: var(--text-muted);
        }

        /* ── BOOK GRID ── */
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 1.5px;
            background: var(--border);
            border: 1px solid var(--border);
        }

        /* ── BOOK CARD ── */
        .book-card {
            background: var(--bg-card);
            padding: 1.5rem;
            transition: background 0.2s ease;
            position: relative;
            overflow: hidden;
        }

        .book-card:hover {
            background: var(--bg-card-hover);
        }

        .book-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0;
            width: 3px; height: 0;
            background: var(--orange);
            transition: height 0.3s ease;
        }

        .book-card:hover::before { height: 100%; }

        .card-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
        }

        .book-id {
            font-family: 'DM Mono', monospace;
            font-size: 10px;
            color: var(--text-muted);
            letter-spacing: 0.05em;
        }

        .genre-badge {
            font-family: 'DM Mono', monospace;
            font-size: 9px;
            padding: 2px 8px;
            border-radius: 2px;
            letter-spacing: 0.06em;
            text-transform: uppercase;
            font-weight: 500;
        }

        .genre-technology    { background: #1a2a3a; color: #5bc0de; border: 1px solid #2a4a6a; }
        .genre-webdev        { background: #1a2a1a; color: #5cb85c; border: 1px solid #2a4a2a; }
        .genre-programming   { background: #2a1a2a; color: #c678dd; border: 1px solid #3a1a3a; }
        .genre-database      { background: #2a2a1a; color: #e5c07b; border: 1px solid #4a3a1a; }
        .genre-ai            { background: #2a1a1a; color: var(--orange-light); border: 1px solid #4a2a1a; }
        .genre-software      { background: #1a1a2a; color: #6699cc; border: 1px solid #2a2a4a; }
        .genre-networking    { background: #1a2a2a; color: #56b6c2; border: 1px solid #1a3a3a; }
        .genre-os            { background: #2a1a1a; color: #e06c75; border: 1px solid #4a1a1a; }
        .genre-algorithms    { background: #1a2a1a; color: #98c379; border: 1px solid #1a4a1a; }
        .genre-ml            { background: #2a2a1a; color: #d19a66; border: 1px solid #4a4a1a; }
        .genre-cybersecurity { background: #2a1a2a; color: #ff79c6; border: 1px solid #3a1a3a; }
        .genre-cloud         { background: #1a1a2a; color: #8be9fd; border: 1px solid #1a1a4a; }

        .book-title {
            font-family: 'Syne', sans-serif;
            font-size: 1.05rem;
            font-weight: 700;
            color: var(--text-primary);
            line-height: 1.3;
            margin-bottom: 0.3rem;
        }

        .book-author {
            font-size: 12px;
            color: var(--orange-light);
            margin-bottom: 0.75rem;
            font-weight: 500;
        }

        .book-description {
            font-size: 12px;
            color: var(--text-secondary);
            line-height: 1.55;
            margin-bottom: 1rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .book-meta-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 6px;
            margin-bottom: 1rem;
        }

        .meta-item {
            display: flex;
            flex-direction: column;
            gap: 1px;
        }

        .meta-label {
            font-family: 'DM Mono', monospace;
            font-size: 9px;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: var(--text-muted);
        }

        .meta-value {
            font-size: 12px;
            color: var(--text-secondary);
            font-weight: 500;
        }

        .meta-isbn {
            font-family: 'DM Mono', monospace;
            font-size: 11px;
        }

        .card-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: 0.75rem;
            border-top: 1px solid var(--border);
        }

        .book-price {
            font-family: 'Syne', sans-serif;
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--orange);
        }

        .book-price-currency {
            font-size: 0.8rem;
            font-weight: 400;
            color: var(--text-muted);
            margin-right: 2px;
        }

        .rating-stars {
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .stars {
            color: var(--yellow);
            font-size: 11px;
            letter-spacing: 1px;
        }

        .rating-num {
            font-family: 'DM Mono', monospace;
            font-size: 11px;
            color: var(--text-muted);
        }

        .availability-tag {
            font-family: 'DM Mono', monospace;
            font-size: 9px;
            padding: 2px 7px;
            border-radius: 2px;
            letter-spacing: 0.06em;
        }

        .avail-instock   { background: #0a2a0a; color: var(--green); border: 1px solid #1a4a1a; }
        .avail-limited   { background: #2a1a00; color: var(--yellow); border: 1px solid #4a3a00; }
        .avail-outstock  { background: #2a0a0a; color: var(--red); border: 1px solid #4a1a1a; }

        /* ── XPATH SECTION ── */
        .xpath-section {
            margin-top: 3rem;
        }

        .xpath-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 1px;
            background: var(--border);
            border: 1px solid var(--border);
        }

        .xpath-card {
            background: var(--bg-card);
            padding: 1.2rem 1.5rem;
            transition: background 0.15s;
        }

        .xpath-card:hover { background: var(--bg-card-hover); }

        .xpath-num {
            font-family: 'DM Mono', monospace;
            font-size: 9px;
            color: var(--text-muted);
            margin-bottom: 0.4rem;
        }

        .xpath-purpose {
            font-size: 12px;
            font-weight: 600;
            color: var(--text-secondary);
            margin-bottom: 0.5rem;
        }

        .xpath-code {
            font-family: 'DM Mono', monospace;
            font-size: 11px;
            color: var(--orange-light);
            background: #1a0a00;
            border: 1px solid #2a1400;
            border-left: 2px solid var(--orange);
            border-radius: 3px;
            padding: 0.5rem 0.75rem;
            word-break: break-all;
        }

        /* ── DTD SECTION ── */
        .dtd-section {
            margin-top: 3rem;
        }

        .code-block {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-left: 3px solid var(--orange);
            border-radius: 4px;
            overflow: hidden;
        }

        .code-block-header {
            background: var(--bg-secondary);
            padding: 0.6rem 1.2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid var(--border);
        }

        .code-block-title {
            font-family: 'DM Mono', monospace;
            font-size: 11px;
            color: var(--text-muted);
            letter-spacing: 0.05em;
        }

        .code-block-lang {
            font-family: 'DM Mono', monospace;
            font-size: 10px;
            color: var(--orange);
            background: var(--orange-dim);
            padding: 2px 8px;
            border-radius: 2px;
        }

        .code-content {
            padding: 1.5rem;
            font-family: 'DM Mono', monospace;
            font-size: 12px;
            line-height: 1.8;
            color: var(--text-secondary);
            white-space: pre;
            overflow-x: auto;
        }

        .code-keyword   { color: #c678dd; }
        .code-element   { color: var(--orange-light); }
        .code-attr      { color: #e5c07b; }
        .code-string    { color: #98c379; }
        .code-comment   { color: #5c6370; font-style: italic; }

        /* ── FOOTER ── */
        footer {
            margin-top: 4rem;
            border-top: 1px solid var(--border);
            background: var(--bg-secondary);
        }

        .footer-inner {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem 2.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .footer-left {
            font-size: 12px;
            color: var(--text-muted);
            line-height: 1.6;
        }

        .footer-left strong { color: var(--text-secondary); }

        .footer-tags {
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
        }

        .footer-tag {
            font-family: 'DM Mono', monospace;
            font-size: 10px;
            padding: 2px 8px;
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 2px;
            color: var(--text-muted);
        }

        /* ── RESPONSIVE ── */
        @media (max-width: 768px) {
            .header-inner { flex-direction: column; }
            .header-meta  { align-items: flex-start; }
            .main-wrapper { padding: 1.5rem 1rem; }
            .books-grid   { grid-template-columns: 1fr; }
            .xpath-grid   { grid-template-columns: 1fr; }
            .stats-inner  { gap: 0; }
        }

        /* ── SCROLL BAR ── */
        ::-webkit-scrollbar { width: 6px; height: 6px; }
        ::-webkit-scrollbar-track { background: var(--bg-primary); }
        ::-webkit-scrollbar-thumb { background: var(--border); border-radius: 3px; }
        ::-webkit-scrollbar-thumb:hover { background: var(--orange); }

        /* ── ANIMATION ── */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(12px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .book-card {
            animation: fadeInUp 0.4s ease both;
        }
    </style>
</head>
<body>

<!-- ══════════════════════════════════════════════
     HEADER
══════════════════════════════════════════════ -->
<header>
    <div class="header-glow"/>
    <div class="header-inner">
        <div>
            <div class="project-badge">Final Year Project — 2024</div>
            <h1>XML <span>Book</span><br/>Catalog</h1>
            <p class="header-subtitle">
                A structured digital library system using XML, DTD validation,<br/>
                XPath queries, and XSLT transformation technology.
            </p>
        </div>
        <div class="header-meta">
            <div class="tech-stack">
                <span class="tech-tag">XML 1.0</span>
                <span class="tech-tag">DTD</span>
                <span class="tech-tag">XPath 2.0</span>
                <span class="tech-tag">XSLT 1.0</span>
                <span class="tech-tag">UTF-8</span>
            </div>
        </div>
    </div>
</header>

<!-- ══════════════════════════════════════════════
     STATS BAR
══════════════════════════════════════════════ -->
<div class="stats-bar">
    <div class="stats-inner">
        <div class="stat-item">
            <span class="stat-label">Total Books</span>
            <span class="stat-value"><xsl:value-of select="count(/catalog/book)"/></span>
            <span class="stat-sub">catalog entries</span>
        </div>
        <div class="stat-item">
            <span class="stat-label">Genres</span>
            <span class="stat-value">12</span>
            <span class="stat-sub">categories</span>
        </div>
        <div class="stat-item">
            <span class="stat-label">In Stock</span>
            <span class="stat-value"><xsl:value-of select="count(/catalog/book[availability='In Stock'])"/></span>
            <span class="stat-sub">available now</span>
        </div>
        <div class="stat-item">
            <span class="stat-label">XPath Queries</span>
            <span class="stat-value">20</span>
            <span class="stat-sub">documented</span>
        </div>
        <div class="stat-item">
            <span class="stat-label">DTD Rules</span>
            <span class="stat-value">13</span>
            <span class="stat-sub">elements defined</span>
        </div>
        <div class="stat-item">
            <span class="stat-label">Total Value</span>
            <span class="stat-value">₹<xsl:value-of select="sum(/catalog/book/price)"/></span>
            <span class="stat-sub">catalog worth</span>
        </div>
    </div>
</div>

<!-- ══════════════════════════════════════════════
     MAIN
══════════════════════════════════════════════ -->
<div class="main-wrapper">

    <!-- Book Catalog Grid -->
    <div class="section-header">
        <div class="section-title">Book Catalog</div>
        <span class="section-count"><xsl:value-of select="count(/catalog/book)"/> entries found</span>
    </div>

    <div class="books-grid">
        <xsl:for-each select="catalog/book">
            <xsl:sort select="title"/>
            <div class="book-card">
                <div class="card-top">
                    <span class="book-id">BOOK–<xsl:value-of select="format-number(@id,'000')"/></span>

                    <xsl:choose>
                        <xsl:when test="genre='Technology'">
                            <span class="genre-badge genre-technology"><xsl:value-of select="genre"/></span>
                        </xsl:when>
                        <xsl:when test="genre='Web Development'">
                            <span class="genre-badge genre-webdev"><xsl:value-of select="genre"/></span>
                        </xsl:when>
                        <xsl:when test="genre='Programming'">
                            <span class="genre-badge genre-programming"><xsl:value-of select="genre"/></span>
                        </xsl:when>
                        <xsl:when test="genre='Database'">
                            <span class="genre-badge genre-database"><xsl:value-of select="genre"/></span>
                        </xsl:when>
                        <xsl:when test="genre='Artificial Intelligence'">
                            <span class="genre-badge genre-ai"><xsl:value-of select="genre"/></span>
                        </xsl:when>
                        <xsl:when test="genre='Software Engineering'">
                            <span class="genre-badge genre-software"><xsl:value-of select="genre"/></span>
                        </xsl:when>
                        <xsl:when test="genre='Networking'">
                            <span class="genre-badge genre-networking"><xsl:value-of select="genre"/></span>
                        </xsl:when>
                        <xsl:when test="genre='Operating Systems'">
                            <span class="genre-badge genre-os"><xsl:value-of select="genre"/></span>
                        </xsl:when>
                        <xsl:when test="genre='Algorithms'">
                            <span class="genre-badge genre-algorithms"><xsl:value-of select="genre"/></span>
                        </xsl:when>
                        <xsl:when test="genre='Machine Learning'">
                            <span class="genre-badge genre-ml"><xsl:value-of select="genre"/></span>
                        </xsl:when>
                        <xsl:when test="genre='Cybersecurity'">
                            <span class="genre-badge genre-cybersecurity"><xsl:value-of select="genre"/></span>
                        </xsl:when>
                        <xsl:otherwise>
                            <span class="genre-badge genre-cloud"><xsl:value-of select="genre"/></span>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>

                <div class="book-title"><xsl:value-of select="title"/></div>
                <div class="book-author">by <xsl:value-of select="author"/></div>
                <div class="book-description"><xsl:value-of select="description"/></div>

                <div class="book-meta-grid">
                    <div class="meta-item">
                        <span class="meta-label">Publisher</span>
                        <span class="meta-value"><xsl:value-of select="publisher"/></span>
                    </div>
                    <div class="meta-item">
                        <span class="meta-label">Year</span>
                        <span class="meta-value"><xsl:value-of select="year"/></span>
                    </div>
                    <div class="meta-item">
                        <span class="meta-label">Pages</span>
                        <span class="meta-value"><xsl:value-of select="pages"/> pp.</span>
                    </div>
                    <div class="meta-item">
                        <span class="meta-label">Language</span>
                        <span class="meta-value"><xsl:value-of select="language"/></span>
                    </div>
                    <div class="meta-item" style="grid-column: span 2;">
                        <span class="meta-label">ISBN</span>
                        <span class="meta-value meta-isbn"><xsl:value-of select="isbn"/></span>
                    </div>
                </div>

                <div class="card-footer">
                    <div>
                        <span class="book-price">
                            <span class="book-price-currency">₹</span>
                            <xsl:value-of select="price"/>
                        </span>
                    </div>

                    <div class="rating-stars">
                        <span class="stars">★★★★★</span>
                        <span class="rating-num"><xsl:value-of select="rating"/>/5</span>
                    </div>

                    <xsl:choose>
                        <xsl:when test="availability='In Stock'">
                            <span class="availability-tag avail-instock">● In Stock</span>
                        </xsl:when>
                        <xsl:when test="availability='Limited Stock'">
                            <span class="availability-tag avail-limited">◐ Limited</span>
                        </xsl:when>
                        <xsl:otherwise>
                            <span class="availability-tag avail-outstock">○ Out of Stock</span>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
            </div>
        </xsl:for-each>
    </div>

    <!-- ── XPath Queries Section ── -->
    <div class="xpath-section">
        <div class="section-header">
            <div class="section-title">XPath Query Reference</div>
            <span class="section-count">20 queries documented</span>
        </div>
        <div class="xpath-grid">
            <div class="xpath-card">
                <div class="xpath-num">QUERY 01</div>
                <div class="xpath-purpose">Select All Books</div>
                <div class="xpath-code">/catalog/book</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 02</div>
                <div class="xpath-purpose">Select All Titles</div>
                <div class="xpath-code">/catalog/book/title</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 03</div>
                <div class="xpath-purpose">Select Book by ID</div>
                <div class="xpath-code">/catalog/book[@id='1']</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 04</div>
                <div class="xpath-purpose">Select Books by Genre</div>
                <div class="xpath-code">/catalog/book[genre='Technology']</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 05</div>
                <div class="xpath-purpose">Books Published After 2018</div>
                <div class="xpath-code">/catalog/book[year > 2018]</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 06</div>
                <div class="xpath-purpose">Books Under ₹600</div>
                <div class="xpath-code">/catalog/book[price &lt; 600]</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 07</div>
                <div class="xpath-purpose">Books by Publisher</div>
                <div class="xpath-code">/catalog/book[publisher="O'Reilly Media"]</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 08</div>
                <div class="xpath-purpose">Count Total Books</div>
                <div class="xpath-code">count(/catalog/book)</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 09</div>
                <div class="xpath-purpose">High-Rated Books (4.5+)</div>
                <div class="xpath-code">/catalog/book[rating > 4.5]</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 10</div>
                <div class="xpath-purpose">Books In Stock</div>
                <div class="xpath-code">/catalog/book[availability='In Stock']</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 11</div>
                <div class="xpath-purpose">Last Book in Catalog</div>
                <div class="xpath-code">/catalog/book[last()]</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 12</div>
                <div class="xpath-purpose">First Three Books</div>
                <div class="xpath-code">/catalog/book[position() &lt;= 3]</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 13</div>
                <div class="xpath-purpose">Sum of All Prices</div>
                <div class="xpath-code">sum(/catalog/book/price)</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 14</div>
                <div class="xpath-purpose">Most Expensive Book</div>
                <div class="xpath-code">/catalog/book[price = max(/catalog/book/price)]</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 15</div>
                <div class="xpath-purpose">Books Over 500 Pages</div>
                <div class="xpath-code">/catalog/book[pages > 500]</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 16</div>
                <div class="xpath-purpose">Author Contains 'Smith'</div>
                <div class="xpath-code">/catalog/book[contains(author, 'Smith')]</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 17</div>
                <div class="xpath-purpose">All ISBNs</div>
                <div class="xpath-code">/catalog/book/isbn</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 18</div>
                <div class="xpath-purpose">English Language Books</div>
                <div class="xpath-code">/catalog/book[language='English']</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 19</div>
                <div class="xpath-purpose">Title and Author Only</div>
                <div class="xpath-code">/catalog/book/title | /catalog/book/author</div>
            </div>
            <div class="xpath-card">
                <div class="xpath-num">QUERY 20</div>
                <div class="xpath-purpose">Distinct Genres</div>
                <div class="xpath-code">distinct-values(/catalog/book/genre)</div>
            </div>
        </div>
    </div>

    <!-- ── DTD Validation Section ── -->
    <div class="dtd-section">
        <div class="section-header">
            <div class="section-title">DTD Validation Schema</div>
            <span class="section-count">books.dtd</span>
        </div>
        <div class="code-block">
            <div class="code-block-header">
                <span class="code-block-title">books.dtd — Document Type Definition</span>
                <span class="code-block-lang">DTD</span>
            </div>
            <div class="code-content">
<span class="code-comment">&lt;!-- books.dtd - DTD for XML Book Catalog --&gt;</span>

<span class="code-keyword">&lt;!ELEMENT</span> <span class="code-element">catalog</span> (<span class="code-attr">book+</span>)<span class="code-keyword">&gt;</span>

<span class="code-keyword">&lt;!ELEMENT</span> <span class="code-element">book</span> (<span class="code-attr">title, author, publisher, year, price,
             genre, isbn, pages, language,
             rating, description, availability</span>)<span class="code-keyword">&gt;</span>
<span class="code-keyword">&lt;!ATTLIST</span> <span class="code-element">book</span>
    <span class="code-attr">id</span> CDATA #REQUIRED
<span class="code-keyword">&gt;</span>

<span class="code-keyword">&lt;!ELEMENT</span> <span class="code-element">title</span>        (#PCDATA)<span class="code-keyword">&gt;</span>
<span class="code-keyword">&lt;!ELEMENT</span> <span class="code-element">author</span>       (#PCDATA)<span class="code-keyword">&gt;</span>
<span class="code-keyword">&lt;!ELEMENT</span> <span class="code-element">publisher</span>    (#PCDATA)<span class="code-keyword">&gt;</span>
<span class="code-keyword">&lt;!ELEMENT</span> <span class="code-element">year</span>         (#PCDATA)<span class="code-keyword">&gt;</span>
<span class="code-keyword">&lt;!ELEMENT</span> <span class="code-element">price</span>        (#PCDATA)<span class="code-keyword">&gt;</span>
<span class="code-keyword">&lt;!ELEMENT</span> <span class="code-element">genre</span>        (#PCDATA)<span class="code-keyword">&gt;</span>
<span class="code-keyword">&lt;!ELEMENT</span> <span class="code-element">isbn</span>         (#PCDATA)<span class="code-keyword">&gt;</span>
<span class="code-keyword">&lt;!ELEMENT</span> <span class="code-element">pages</span>        (#PCDATA)<span class="code-keyword">&gt;</span>
<span class="code-keyword">&lt;!ELEMENT</span> <span class="code-element">language</span>     (#PCDATA)<span class="code-keyword">&gt;</span>
<span class="code-keyword">&lt;!ELEMENT</span> <span class="code-element">rating</span>       (#PCDATA)<span class="code-keyword">&gt;</span>
<span class="code-keyword">&lt;!ELEMENT</span> <span class="code-element">description</span>  (#PCDATA)<span class="code-keyword">&gt;</span>
<span class="code-keyword">&lt;!ELEMENT</span> <span class="code-element">availability</span> (#PCDATA)<span class="code-keyword">&gt;</span>
            </div>
        </div>
    </div>

</div>

<!-- ══════════════════════════════════════════════
     FOOTER
══════════════════════════════════════════════ -->
<footer>
    <div class="footer-inner">
        <div class="footer-left">
            <strong>XML Book Catalog</strong> — Final Year Project<br/>
            Built with XML 1.0 · DTD Validation · XPath 2.0 · XSLT 1.0 Transformation
        </div>
        <div class="footer-tags">
            <span class="footer-tag">books.xml</span>
            <span class="footer-tag">books.dtd</span>
            <span class="footer-tag">books.xsl</span>
            <span class="footer-tag">xpath_queries.txt</span>
        </div>
    </div>
</footer>

</body>
</html>
</xsl:template>
</xsl:stylesheet>
