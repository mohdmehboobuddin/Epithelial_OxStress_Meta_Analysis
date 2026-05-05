import matplotlib.pyplot as plt
import matplotlib.patches as patches
import os

os.makedirs("figures", exist_ok=True)

# Lowered to 300 DPI to respect WSL memory limits
fig, ax = plt.subplots(figsize=(12, 7), dpi=300)
ax.axis('off')

color_ros = '#ff9999'      
color_triage = '#e0e0e0'   
color_turq = '#40e0d0'     
color_yellow = '#ffdf00'   

def draw_box(ax, x, y, width, height, text, facecolor, edgecolor='black', text_color='black'):
    box = patches.FancyBboxPatch((x, y), width, height,
                                 boxstyle="round,pad=0.1",
                                 ec=edgecolor, fc=facecolor, lw=1.5)
    ax.add_patch(box)
    ax.text(x + width/2, y + height/2, text, ha='center', va='center',
            fontsize=12, fontweight='bold', family='sans-serif', color=text_color)

draw_box(ax, 4.5, 5.5, 3, 1, "Reactive Oxygen Species\n(Oxidative Stress)", color_ros)
draw_box(ax, 4.5, 4.0, 3, 1, "Epithelial Metabolic Triage\n(Halt & Fortify)", color_triage)
draw_box(ax, 0.5, 2.5, 4.0, 1, "Turquoise Module (ME3)\nGenomic Suppression", color_turq)
draw_box(ax, 0.5, 0.5, 4.0, 1.2, "- Cell Cycle Arrest\n- Halting DNA Repair\n- Stopping Chromatin Remodeling", 'white', color_turq)
draw_box(ax, 7.5, 2.5, 4.0, 1, "Yellow Module (ME4)\nStructural Shield", color_yellow)
draw_box(ax, 7.5, 0.5, 4.0, 1.2, "+ Cadherins (CDH12, CDH7)\n+ Protocadherin Fortification\n+ AKR1B10 Detoxification", 'white', color_yellow)

style = "Simple, tail_width=1.5, head_width=8, head_length=10"
kw = dict(arrowstyle=style, color="black")

ax.add_patch(patches.FancyArrowPatch((6.0, 5.5), (6.0, 5.0), **kw))
ax.add_patch(patches.FancyArrowPatch((4.5, 4.5), (2.5, 3.5), connectionstyle="arc3,rad=.2", **kw))
ax.add_patch(patches.FancyArrowPatch((7.5, 4.5), (9.5, 3.5), connectionstyle="arc3,rad=-.2", **kw))
ax.add_patch(patches.FancyArrowPatch((2.5, 2.5), (2.5, 1.7), **kw))
ax.add_patch(patches.FancyArrowPatch((9.5, 2.5), (9.5, 1.7), **kw))

plt.title("Conserved Structural Defense Architecture in Epithelial Tissues",
          fontsize=16, fontweight='bold', pad=20)
plt.text(6.0, -0.5, "Author: Mohd Mehboob Uddin", ha='center', fontsize=10, fontstyle='italic')

# Removed tight_layout and lowered savefig DPI
plt.subplots_adjust(left=0.05, right=0.95, top=0.9, bottom=0.1)
plt.savefig("figures/Graphical_Abstract.png", dpi=300)
print("Successfully generated figures/Graphical_Abstract.png at 300 DPI.")
plt.close()
