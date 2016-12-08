require 'spec_helper'
require_relative '../simulator'

describe 'Simulator' do
  let!(:simulator) { Simulator.new }

  subject do
    commands.each { |command| simulator.dispatch(command) }
    simulator.dispatch('REPORT')
  end

  describe 'placing' do
    let(:commands) { ['PLACE 1,2,SOUTH'] }
    it { expect{ subject }.to output(/1,2,SOUTH/).to_stdout}
  end

  describe 'moving' do
    let(:commands) { ['PLACE 0,0,NORTH', 'MOVE'] }
    it { expect{ subject }.to output(/0,1,NORTH/).to_stdout }
  end

  describe 'rotating' do
    let(:commands) { ['PLACE 0,0,NORTH', 'LEFT'] }
    it { expect{ subject }.to output(/0,0,WEST/).to_stdout }
  end

  describe 'rotating and moving' do
    let(:commands) { ['PLACE 1,2,EAST', 'MOVE', 'MOVE', 'LEFT', 'MOVE'] }
    it { expect{ subject }.to output(/3,3,NORTH/).to_stdout }
  end

  describe 'commands before a PLACE' do
    let(:commands) { ['MOVE', 'LEFT', 'RIGHT', 'PLACE 1,1,SOUTH'] }

    it 'ignores the commands' do
      expect{ subject }.to output(/1,1,SOUTH/).to_stdout
    end
  end

  describe 'PLACE that would cause the robot to fall from the table' do
    let(:commands) { ['PLACE 0,0,NORTH', 'PLACE -1,0,NORTH', 'MOVE'] }

    it 'ignores the PLACE' do
      expect{ subject }.to output(/0,1,NORTH/).to_stdout
    end
  end

  describe 'MOVE that would cause the robot to fall from the table' do
    let(:commands) { ['PLACE 0,5,NORTH', 'MOVE'] }

    it 'ignores the MOVE' do
      expect{ subject }.to output(/0,5,NORTH/).to_stdout
    end
  end

  describe 'PLACE with invalid orientations but valid co-ordinates' do
    let(:commands) { ['PLACE 0,0,WOMBLES'] }

    it 'ignores the PLACE' do
      expect{ subject }.to output(/Ignoring REPORT until robot is PLACED./).to_stdout
    end
  end

  describe 'PLACE with valid orientations but invalid co-ordinates' do
    let(:commands) { ['PLACE -1,-1,NORTH'] }

    it 'ignores the PLACE' do
      expect{ subject }.to output(/Ignoring REPORT until robot is PLACED./).to_stdout
    end
  end

  describe 'succesive valid PLACEs' do
    let(:commands) { ['PLACE -1,-1,NORTH', 'PLACE 0,0,SOUTH'] }

    it 'applies each PLACE' do
      expect{ subject }.to output(/0,0,SOUTH/).to_stdout
    end
  end
end