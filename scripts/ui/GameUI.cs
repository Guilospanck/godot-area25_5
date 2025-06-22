#nullable enable
using Godot;
using System;
using System.Collections.Generic;

record struct CurrentUIStats
{
	public int CurrentCount { get; set; }
	public StatUI Instance { get; set; }
};

public partial class GameUI : Control
{

	private HBoxContainer? _weaponsContainerUI = null;
	private HBoxContainer? _statsContainerUI = null;

	private PackedScene? _stat = null;

	private Dictionary<String, CurrentUIStats> _currentStats = new Dictionary<string, CurrentUIStats>();

	// ################################ Signals ######################################
	private void _onWeaponSwitch(WeaponResource _weaponResource, String shortcut)
	{
		_updateWeaponUiActiveState(shortcut);
	}

	private void _onStatFound(StatResource statResource)
	{
		if (_stat == null || _statsContainerUI == null)
		{
			GD.Print("Cannot add new stat found due to _stat or _statsContainerUI being null.");
			return;
		}

		String statName = statResource.Name;
		int count = 1;

		Texture2D texture = ResourceLoader.Load<Texture2D>(statResource.TexturePath);
		String quantity = $"x{count}";

		if (_currentStats.ContainsKey(statName))
		{
			CurrentUIStats current = _currentStats[statName];

			count = current.CurrentCount + 1;
			quantity = $"x{count}";
			StatUI statUIInstance = current.Instance;

			// Update record (you have to update the whole record)
			current.CurrentCount = count;
			_currentStats[statName] = current;

			statUIInstance.UpdateData(texture, quantity);
			return;
		}

		StatUI statUI = _stat.Instantiate<StatUI>();
		_statsContainerUI.AddChild(statUI);

		_currentStats.Add(statName, new CurrentUIStats { CurrentCount = count, Instance = statUI });

		statUI.UpdateData(texture, quantity);
	}
	// ########################################################################

	private void _updateWeaponUiActiveState(String shortcut)
	{
		if (_weaponsContainerUI == null)
		{
			GD.Print("Cannot set UI weapon active state because `Weapons` is null");
			return;
		}

		foreach (var child in _weaponsContainerUI.GetChildren())
		{
			if (child == null)
			{
				GD.Print("Skipping loop because child is null.");
				continue;
			}

			Label label = child.GetNode<Label>("CenterContainer/ShortcutPanelContainer/ShortcutLabel");
			if (label.Text == shortcut)
			{
				(child as SlotUI).SetActive();
			}
			else
			{
				(child as SlotUI).SetInactive();
			}
		}
	}

	private void _connectSignals()
	{
		Signals.Instance.WeaponSwitch += _onWeaponSwitch;
		Signals.Instance.StatFound += _onStatFound;
	}

	private void _initialiseNodes()
	{
		_weaponsContainerUI = GetNode<HBoxContainer>("WeaponsContainer/Weapons");
		_statsContainerUI = GetNode<HBoxContainer>("StatsContainer/Stats");
		_stat = ResourceLoader.Load<PackedScene>("res://scenes/stat_ui.tscn");
	}

	public override void _Ready()
	{
		base._Ready();

		_initialiseNodes();
		_connectSignals();
		_updateWeaponUiActiveState("1"); // Set the first weapon as active
	}
}
